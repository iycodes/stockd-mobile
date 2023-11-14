// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginModel _$UserLoginModelFromJson(Map<String, dynamic> json) =>
    UserLoginModel(
      json['email'] as String,
      json['pswd'] as String,
    );

Map<String, dynamic> _$UserLoginModelToJson(UserLoginModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'pswd': instance.pswd,
    };

LoggedInUserModel _$LoggedInUserModelFromJson(Map<String, dynamic> json) =>
    LoggedInUserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      savedItems: (json['savedItems'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String,
      orders: (json['orders'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList() ??
          [],
      cart: json['cart'] ?? {},
      ratings: (json['ratings'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList() ??
          [],
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$LoggedInUserModelToJson(LoggedInUserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'orders': instance.orders,
      'cart': instance.cart,
      'ratings': instance.ratings,
      'savedItems': instance.savedItems,
    };
