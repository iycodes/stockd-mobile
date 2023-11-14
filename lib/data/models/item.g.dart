// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      sellerId: json['sellerId'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      gender: json['gender'] as String,
      thumbnail: json['thumbnail'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      rating: json['rating'] ?? {},
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      subcategory: json['subcategory'] as List<dynamic>? ?? [],
      isSaved: json['isSaved'] as bool? ?? false,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'gender': instance.gender,
      'category': instance.category,
      'thumbnail': instance.thumbnail,
      'images': instance.images,
      'subcategory': instance.subcategory,
      'colors': instance.colors,
      'sellerId': instance.sellerId,
      'description': instance.description,
      'rating': instance.rating,
      'isSaved': instance.isSaved,
    };

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
      (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemListToJson(ItemList instance) => <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
