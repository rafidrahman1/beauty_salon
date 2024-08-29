import 'package:flutter/material.dart';
import 'package:beauty_salon/model/product.dart';
import 'package:beauty_salon/services/product_service.dart';
import 'package:beauty_salon/screens/category_screen.dart';
import 'package:beauty_salon/global.dart' as globals;

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({required this.productId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: FutureBuilder<Product>(
        future: ProductService().fetchProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Product not found'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: globals.selectedProducts.length,
                      itemBuilder: (context, index) {
                        final product = globals.selectedProducts[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text('Time: ${product.time} min | Price: \$${product.price}'),
                        );
                      },
                    ),
                  ),
                  const Spacer(), // Push the button to the bottom
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the CategoryScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryScreen(townId: globals.globalTownId),
                        ),
                      );
                    },
                    child: const Text('Add More Products'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
