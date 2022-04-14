import 'package:untitled/product_api.dart';
import 'package:http/http.dart' as http;

class Product {
  final String title;
  final List<dynamic> images;
  final int price;

  const Product({
    required this.title,
    required this.images,
    required this.price,
  });

  static Future<List<Product>> getProducts(http.Client client, int offset, int limit) async {
    return ProductApi().fetchProducts(client, offset, limit);
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'] as String,
      images: json['images'] as List<dynamic>,
      price: json['price'] as int,
    );
  }
}