class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String imageUrl;
  final int productCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.imageUrl,
    required this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String,
      productCount: json['productCount'] as int? ?? 0,
    );
  }
}
