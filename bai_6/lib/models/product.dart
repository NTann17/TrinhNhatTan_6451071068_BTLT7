class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      thumbnail: json['thumbnail'] as String? ?? '',
    );
  }
}
