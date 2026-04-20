// API Constants
class ApiConstants {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productEndpoint = '/products';
  
  // Ví dụ: https://fakestoreapi.com/products/1
  static String getProductUrl(int productId) => '$baseUrl$productEndpoint/$productId';
}

// App Constants
class AppConstants {
  static const String appTitle = 'Product Detail';
  static const Duration timeoutDuration = Duration(seconds: 10);
}
