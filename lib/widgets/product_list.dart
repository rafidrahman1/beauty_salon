import 'package:flutter/material.dart';
import 'package:beauty_salon/model/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final void Function(int) onRemoveProduct;

  const ProductList({
    required this.products,
    required this.onRemoveProduct,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(
              'Time: ${product.time} min | Price: \$${product.price}'),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.red),
            onPressed: () => onRemoveProduct(index),
          ),
        );
      },
    );
  }
}
