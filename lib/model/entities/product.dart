//TODO: code generation https://docs.flutter.dev/development/data-and-backend/json

class Product {
  final String title;
  final String? description;
  final List<dynamic>? images;
  final int price;

  const Product({
    required this.title,
    required this.description,
    required this.images,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'] as String,
      description: json['productDescription'] as String?,
      images: json['images'] as List<dynamic>?,
      price: json['price'] as int,
    );
  }
}