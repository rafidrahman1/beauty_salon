import 'package:flutter/material.dart';
import 'package:beauty_salon/model/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductTile({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text(
          'Time: ${product.time} min | Price: \$${product.price}'),
      onTap: onTap,
    );
  }
}
