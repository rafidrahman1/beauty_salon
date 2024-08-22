import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'category_screen.dart';

class ServicesScreen extends StatefulWidget {
  final Category category;

  const ServicesScreen({required this.category, super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late Future<List<Service>> _servicesFuture;

  @override
  void initState() {
    super.initState();
    _servicesFuture = fetchServices(widget.category.name);
  }

  Future<List<Service>> fetchServices(String category) async {
    final response = await http.get(Uri.parse('https://yourapi.com/services?category=$category'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Service.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category.name} Services'),
      ),
      body: FutureBuilder<List<Service>>(
        future: _servicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No services found'));
          } else {
            final services = snapshot.data!;

            return ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(services[index].name),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Service {
  final String name;

  Service({required this.name});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'] ?? '',
    );
  }
}
