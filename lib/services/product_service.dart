import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:beauty_salon/config.dart';
import 'package:beauty_salon/model/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts(int categoryId) async {
    final response = await http.get(Uri.parse('${Config.baseUrl}/product/category/$categoryId'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.reasonPhrase}');
    }
  }
}