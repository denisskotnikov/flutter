import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl),
          radius: 25,
        ),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Артикул: ${product.article}'),
            Text('Размер: ${product.size}'),
            Text('Цена: ${product.price} ₽'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Товар добавлен в избранное'),
                content: Text('${product.name} (${product.article})'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ProductDetailsModal(product: product),
          );
        },
      ),
    );
  }
}

class ProductDetailsModal extends StatelessWidget {
  final Product product;

  const ProductDetailsModal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            product.imageUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            product.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text('Артикул: ${product.article}'),
          Text('Размер: ${product.size}'),
          Text('Цена: ${product.price} ₽',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}