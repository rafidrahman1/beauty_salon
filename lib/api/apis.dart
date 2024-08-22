import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:beauty_salon/model/category.dart';

Future<List<Category>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://yourapi.com/categories'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}