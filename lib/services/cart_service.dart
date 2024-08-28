import 'package:beauty_salon/model/cart.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Cart> _cartItems = [];

  List<Cart> get cartItems => _cartItems;

  void addToCart(Cart item) {
    final existingItem = _cartItems.firstWhere(
          (cartItem) => cartItem.productId == item.productId,
      orElse: () => Cart(productId: -1, name: '', price: 0),
    );

    if (existingItem.productId != -1) {
      existingItem.quantity += item.quantity;
    } else {
      _cartItems.add(item);
    }
  }

  void clearCart() {
    _cartItems.clear();
  }
}
