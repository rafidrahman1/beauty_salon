import 'package:flutter/material.dart';
import 'package:beauty_salon/model/product.dart';
import 'package:beauty_salon/services/product_service.dart';

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
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 10),
                  Text('Time: ${product.time} min', style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 5),
                  Text('Price: \$${product.price}', style: Theme.of(context).textTheme.bodyLarge),

                ],
              ),
            );
          }
        },
      ),
    );
  }
}
