import 'package:beauty_salon/screens/appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:beauty_salon/services/product_service.dart';
import 'package:beauty_salon/model/product.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';  // Import the detail screen

class ProductScreen extends StatefulWidget {
  final int categoryId;

  const ProductScreen({required this.categoryId, super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = ProductService().fetchProducts(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            final products = snapshot.data!;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Time: ${product.time} min | Price: \$${product.price}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentScreen(productId: product.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartScreen(),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}