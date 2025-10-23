import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, size: 64, color: Colors.pink),
            SizedBox(height: 16),
            Text(
              'Избранные товары',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}