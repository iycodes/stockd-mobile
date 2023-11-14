import 'package:json_annotation/json_annotation.dart';

part "cart.g.dart";

@JsonSerializable(
  explicitToJson: true,
)
class Cart {
  String ownerId;
  List<CartItem> cartItems;
  Cart(this.ownerId, this.cartItems);
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
)
class CartItem {
  String cartId;
  String itemId;
  int quantity;
  String? color;
  String? size;
  int? numberSize;

  CartItem({
    required this.cartId,
    required this.itemId,
    required this.quantity,
    this.color,
    this.size,
    this.numberSize,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
