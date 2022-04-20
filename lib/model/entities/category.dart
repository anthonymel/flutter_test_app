//TODO: code generation https://docs.flutter.dev/development/data-and-backend/json

class Category {
  final int categoryId;
  final String title;
  final String? imageUrl;
  final int hasSubcategories;
  final String? categoryDescription;

  const Category({
    required this.categoryId,
    required this.title,
    this.imageUrl,
    required this.hasSubcategories,
    this.categoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'] as int,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String?,
      hasSubcategories: json['hasSubcategories'] as int,
      categoryDescription: json['categoryDescription'] as String?,
    );
  }
}