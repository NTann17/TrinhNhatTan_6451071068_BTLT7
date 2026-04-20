class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.rating,
  });

  // Factory constructor để parse JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    // Helper function để convert sang double an toàn
    double _toDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        return double.tryParse(value) ?? 0.0;
      }
      return 0.0;
    }

    int _toInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) {
        return int.tryParse(value) ?? 0;
      }
      return 0;
    }

    return Product(
      id: _toInt(json['id']),
      title: (json['title'] ?? '').toString(),
      price: _toDouble(json['price']),
      description: (json['description'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      rating: _toDouble(json['rating']),
    );
  }

  // Chuyển đổi thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
      'rating': rating,
    };
  }
}
