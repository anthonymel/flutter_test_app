import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String title;
  final String? description;
  final List<dynamic>? images;
  final int price;
  int cartCounter;

  Product({
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    this.cartCounter = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
