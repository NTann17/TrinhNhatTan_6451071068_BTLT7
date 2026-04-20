import 'package:bai_6/models/product.dart';
import 'package:bai_6/utils/api_client.dart';
import 'package:flutter/foundation.dart';

class ProductSearchController extends ChangeNotifier {
  ProductSearchController({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  List<Product> _products = <Product>[];
  bool _isLoading = false;
  String? _errorMessage;
  String _currentKeyword = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get currentKeyword => _currentKeyword;

  Future<void> searchProducts(String keyword) async {
    _currentKeyword = keyword.trim();
    _setLoading(true);
    _errorMessage = null;

    try {
      final response = await _apiClient.getJson(
        path: _currentKeyword.isEmpty ? '/products' : '/products/search',
        queryParameters:
            _currentKeyword.isEmpty ? <String, String>{'limit': '20'} : <String, String>{'q': _currentKeyword},
      );

      final dynamic rawProducts = response['products'];
      if (rawProducts is! List<dynamic>) {
        throw Exception('Products list not found');
      }

      _products = rawProducts
          .whereType<Map<String, dynamic>>()
          .map(Product.fromJson)
          .toList();
    } catch (_) {
      _products = <Product>[];
      _errorMessage = 'Khong tim duoc du lieu. Vui long thu lai.';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _apiClient.dispose();
    super.dispose();
  }
}
