class Service {
  final String name;

  Service({required this.name});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'] ?? '',
    );
  }
}
