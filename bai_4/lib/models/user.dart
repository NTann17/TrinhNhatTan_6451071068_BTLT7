class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.avatar,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    // Handle address - can be String or Map
    String addressString = '';
    final addressData = json['address'];
    if (addressData is String) {
      addressString = addressData;
    } else if (addressData is Map) {
      // If address is an object, extract the 'street' field
      addressString = addressData['street'] ?? '';
    }

    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: addressString,
      avatar: json['avatar'] ?? '',
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'avatar': avatar,
    };
  }

  // Create a copy with modified fields
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
    );
  }
}
