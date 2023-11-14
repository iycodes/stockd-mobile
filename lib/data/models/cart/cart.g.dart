// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      json['ownerId'] as String,
      (json['cartItems'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'ownerId': instance.ownerId,
      'cartItems': instance.cartItems.map((e) => e.toJson()).toList(),
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      cartId: json['cartId'] as String,
      itemId: json['itemId'] as String,
      quantity: json['quantity'] as int,
      color: json['color'] as String?,
      size: json['size'] as String?,
      numberSize: json['numberSize'] as int?,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'cartId': instance.cartId,
      'itemId': instance.itemId,
      'quantity': instance.quantity,
      'color': instance.color,
      'size': instance.size,
      'numberSize': instance.numberSize,
    };
