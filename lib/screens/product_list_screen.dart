import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_cubit.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camp David - Товары'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: BlocBuilder<ProductCubit, List<Product>>(
        builder: (context, products) {
          if (products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final groupedProducts = context.read<ProductCubit>().getGroupedProducts();
          
          return ListView.builder(
            itemCount: groupedProducts.length,
            itemBuilder: (context, index) {
              final groupName = groupedProducts.keys.elementAt(index);
              final groupProducts = groupedProducts[groupName]!;
              
              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  leading: const Icon(Icons.category),
                  title: Text(
                    groupName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: groupProducts.map((product) => 
                    ProductCard(product: product)
                  ).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}