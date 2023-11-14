import 'package:json_annotation/json_annotation.dart';

part "user.g.dart";

@JsonSerializable(
  explicitToJson: true,
)
class UserLoginModel {
  final String email;
  final String pswd;
  UserLoginModel(this.email, this.pswd);
  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
)
class LoggedInUserModel {
  final String email;
  final String name;
  final String createdAt;
  final String updatedAt;
  @JsonKey(defaultValue: [])
  final List<Object>? orders;
  @JsonKey(defaultValue: {})
  final Object? cart;
  @JsonKey(defaultValue: [])
  final List<Object>? ratings;

  final List<String> savedItems;
  LoggedInUserModel({
    required this.email,
    required this.name,
    required this.savedItems,
    required this.createdAt,
    required this.orders,
    required this.cart,
    required this.ratings,
    required this.updatedAt,
  });
  factory LoggedInUserModel.fromJson(Map<String, dynamic> json) =>
      _$LoggedInUserModelFromJson(json);
  Map<String, dynamic> toJon() => _$LoggedInUserModelToJson(this);
}
