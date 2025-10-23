// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['article', 'name'],
  );
  return Product(
    article: json['article'] as String,
    name: json['name'] as String,
    size: json['size'] as String,
    price: (json['price'] as num).toDouble(),
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'article': instance.article,
      'name': instance.name,
      'size': instance.size,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
    };
