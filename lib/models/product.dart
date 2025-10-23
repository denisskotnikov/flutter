import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(required: true)
  final String article;

  @JsonKey(required: true)
  final String name;

  final String size;
  final double price;
  final String imageUrl;

  Product({
    required this.article,
    required this.name,
    required this.size,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? article,
    String? name,
    String? size,
    double? price,
    String? imageUrl,
  }) {
    return Product(
      article: article ?? this.article,
      name: name ?? this.name,
      size: size ?? this.size,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}