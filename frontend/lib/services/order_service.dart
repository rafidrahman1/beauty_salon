import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class OrderService {
  static Future<double?> createOrder({
    required String name,
    required String email,
    required String phone,
    required String comment,
    required String details,
    required double price,
    required List<int> productIds,
  }) async {
    try {
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
          'productIds': productIds,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Check if the response contains the 'order' field
        if (responseData.containsKey('order') &&
            responseData.containsKey('calculatedPrice')) {
          return responseData['calculatedPrice'] as double?;
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to create order: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Propagate the exception
    }
  }
}
