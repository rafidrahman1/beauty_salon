import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class OrderService {
  static Future<bool> createOrder({
    required String name,
    required String email,
    required String phone,
    required String comment,
    required String details,
    required double price,
  }) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/order/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'email': email,
        'phone': phone,
        'comment': comment,
        'details': details,
        'price': price,
      }),
    );

    return response.statusCode == 200;
  }
}
