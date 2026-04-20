import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../utils/constants.dart';

class ProductService {
  // Gọi API để lấy chi tiết 1 sản phẩm
  static Future<Product> fetchProductDetail(int productId) async {
    try {
      final url = Uri.parse(ApiConstants.getProductUrl(productId));
      
      final response = await http.get(url).timeout(
        AppConstants.timeoutDuration,
        onTimeout: () => throw TimeoutException('Kết nối timeout'),
      );

      if (response.statusCode == 200) {
        // Parse JSON và tạo Product object
        try {
          final jsonData = jsonDecode(response.body);
          if (jsonData is! Map<String, dynamic>) {
            throw Exception('Invalid JSON format: expected object');
          }
          return Product.fromJson(jsonData);
        } on FormatException catch (e) {
          throw Exception('Lỗi parse JSON: ${e.message}');
        }
      } else if (response.statusCode == 404) {
        throw Exception('Sản phẩm không tồn tại');
      } else {
        throw Exception('Lỗi server: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      throw Exception('Kết nối bị timeout: ${e.message}');
    } on http.ClientException catch (e) {
      throw Exception('Lỗi kết nối: ${e.message}');
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
}
