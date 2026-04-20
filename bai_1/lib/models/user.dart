class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;
  final String company;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.website = '',
    this.company = '',
  });

  /// Parse JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? 'N/A',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      company: json['company']?['name'] ?? '',
    );
  }

  /// Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'website': website,
      'company': company,
    };
  }
}
