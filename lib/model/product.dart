class Product {
  final int id;
  final String name;
  final int time;
  final int price;

  Product({required this.id, required this.name, required this.time, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      time: json['time'] ?? 0,
      price: json['price'] ?? 0,
    );
  }
}