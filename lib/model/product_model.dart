class ProductModel {
  final int id;
  final String name;
  final double price;
  final double? originalPrice;
  final int discountPercentage;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.discountPercentage,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice']).toDouble()
          : null,
      discountPercentage: json['discountPercentage'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
    );
  }
}
