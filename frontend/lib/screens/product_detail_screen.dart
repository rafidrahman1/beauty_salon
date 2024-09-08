import 'package:flutter/material.dart';
import 'package:beauty_salon/global.dart' as globals;
import 'package:beauty_salon/widgets/product_list.dart';
import 'package:beauty_salon/widgets/action_buttons.dart';
import 'category_screen.dart';
import 'user_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: globals.selectedProducts.isEmpty
          ? _buildNoProductsView()
          : _buildProductListView(),
    );
  }

  Widget _buildNoProductsView() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CategoryScreen(townId: globals.globalTownId),
            ),
          );
        },
        child: const Text('No products selected. Go back to Category'),
      ),
    );
  }

  Widget _buildProductListView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ProductList(
              products: globals.selectedProducts,
              onRemoveProduct: _removeProduct,
            ),
          ),
          ActionButtons(
            onAddMore: _navigateToCategoryScreen,
            onConfirmOrder: _confirmOrder,
          ),
        ],
      ),
    );
  }

  void _removeProduct(int index) {
    if (index >= 0 && index < globals.selectedProducts.length) {
      setState(() {
        globals.selectedProducts.removeAt(index);
      });
    } else {
      _showErrorSnackBar('Invalid index for product removal.');
    }
  }

  void _confirmOrder() {
    if (globals.selectedProducts.isNotEmpty) {
      // Save product IDs globally
      globals.globalProductIds = globals.selectedProducts.map((product) => product.id).toList();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserScreen()),
      );
      _showSuccessSnackBar('All Products Added');
    } else {
      _showErrorSnackBar('No products to confirm.');
    }
  }

  void _navigateToCategoryScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CategoryScreen(townId: globals.globalTownId),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
