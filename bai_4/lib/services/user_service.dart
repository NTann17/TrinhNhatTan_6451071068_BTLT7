import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserService {
  // API Base URL - thay đổi URL theo API của bạn
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET: Lấy thông tin user theo ID
  static Future<User> getUser(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return User.fromJson(json);
      } else {
        throw Exception('Lỗi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải dữ liệu: $e');
    }
  }

  // PUT: Cập nhật thông tin user
  static Future<User> updateUser(int userId, User user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/$userId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Request timeout'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return User.fromJson(json);
      } else {
        throw Exception('Lỗi cập nhật: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi cập nhật: $e');
    }
  }
}
