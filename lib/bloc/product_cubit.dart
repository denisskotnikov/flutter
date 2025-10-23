import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../models/product.dart';
import '../data/database.dart';

class ProductCubit extends Cubit<List<Product>> {
  final DataBasePrefs database;
  
  ProductCubit({required this.database}) : super([]);

  Future<void> loadProducts() async {
    try {
      final productsJson = await database.getProducts();
      
      if (productsJson.isEmpty) {
        // Initial demo data
        final demoProducts = [
          Product(
            article: 'CD001',
            name: 'Футболка',
            size: 'M',
            price: 1999.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            article: 'CD002',
            name: 'Футболка',
            size: 'L',
            price: 1999.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            article: 'CD003',
            name: 'Джинсы',
            size: '32',
            price: 4999.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            article: 'CD004',
            name: 'Джинсы',
            size: '34',
            price: 4999.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            article: 'CD005',
            name: 'Куртка',
            size: 'L',
            price: 8999.0,
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ];
        
        await database.saveProducts(demoProducts);
        emit(demoProducts);
      } else {
        final products = productsJson.map((json) => Product.fromJson(json)).toList();
        emit(products);
      }
    } catch (e) {
      emit([]);
    }
  }

  Future<void> addProduct(Product product) async {
    final newProducts = List<Product>.from(state)..add(product);
    await database.saveProducts(newProducts);
    emit(newProducts);
  }

  Future<void> updateProduct(Product oldProduct, Product newProduct) async {
    final newProducts = List<Product>.from(state);
    final index = newProducts.indexWhere((p) => p.article == oldProduct.article);
    if (index != -1) {
      newProducts[index] = newProduct;
      await database.saveProducts(newProducts);
      emit(newProducts);
    }
  }

  Future<void> deleteProduct(Product product) async {
    final newProducts = List<Product>.from(state)..removeWhere((p) => p.article == product.article);
    await database.saveProducts(newProducts);
    emit(newProducts);
  }

  Map<String, List<Product>> getGroupedProducts() {
    final grouped = groupBy(state, (Product p) => p.name);
    grouped.forEach((name, products) {
      products.sort((a, b) => a.article.compareTo(b.article));
    });
    return grouped;
  }
}