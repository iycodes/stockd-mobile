import 'package:json_annotation/json_annotation.dart';
part "item.g.dart";

@JsonSerializable(
  explicitToJson: true,
)
class Item {
  String id;
  String name;
  int price;
  String gender;
  String category;
  String thumbnail;
  List<String>? images;
  @JsonKey(defaultValue: [])
  List subcategory;
  @JsonKey(defaultValue: [])
  List<Map<String, dynamic>>? colors;
  final String sellerId;
  final String description;
  @JsonKey(defaultValue: {})
  final Object? rating;
  @JsonKey(defaultValue: false)
  bool isSaved;
  @override
  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.sellerId,
    required this.price,
    required this.description,
    required this.gender,
    required this.thumbnail,
    this.images,
    this.rating,
    this.colors,
    this.subcategory = const [],
    this.isSaved = false,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemList {
  // List<Map<String, dynamic>> items;
  List<Item> items;
  ItemList(this.items);

  // factory ItemList.fromJson(Map<String, dynamic> json) =>
  //     _$ItemListFromJson(json);

  factory ItemList.fromJson(List<dynamic> json) =>
      ItemList(json.map((e) => Item.fromJson(e)).toList());

  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}




// /// Tell json_serializable to use "defaultValue" if the JSON doesn't
// /// contain this key or if the value is `null`.
// @JsonKey(defaultValue: false)
// final bool isAdult;

// /// When `true` tell json_serializable that JSON must contain the key, 
// /// If the key doesn't exist, an exception is thrown.
// @JsonKey(required: true)
// final String id;

// /// When `true` tell json_serializable that generated code should 
// /// ignore this field completely. 
// @JsonKey(ignore: true)
// final String verificationCode;
