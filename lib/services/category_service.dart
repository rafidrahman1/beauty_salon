import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:beauty_salon/config.dart';
import 'package:beauty_salon/model/category.dart';

class CategoryService {
  Future<List<Category>> fetchCategories(int townId) async {
    final uri = Uri.parse('${Config.baseUrl}/category/town/$townId');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}