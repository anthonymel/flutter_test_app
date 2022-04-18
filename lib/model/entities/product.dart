class Product {
  final String title;
  final List<dynamic>? images;
  final int price;

  const Product({
    required this.title,
    required this.images,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'] as String,
      images: json['images'] as List<dynamic>?,
      price: json['price'] as int,
    );
  }
}