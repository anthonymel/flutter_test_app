// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      images: json['images'] as List<dynamic>?,
      price: json['price'] as int,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
      'price': instance.price,
    };
