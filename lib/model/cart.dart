
class Cart {
  final int productId;
  final String name;
  final int price;
  late final int quantity;

  Cart({
    required this.productId,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}
