import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int productId;
  final String title;
  final String? description;
  final List<dynamic>? images;
  final int price;

  Product({
    required this.productId,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
