/// API Endpoints and Constants
class AppConstants {
  // Base URL for API (thay đổi theo server thực tế của bạn)
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // API Endpoints
  static const String createPostEndpoint = '$baseUrl/posts';

  // Response messages
  static const String successMessage = 'Post created successfully';
  static const String errorMessage = 'Failed to create post';
  static const String networkErrorMessage =
      'Network error occurred. Please check your connection.';
  static const String validationErrorMessage = 'Please fill in all fields';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
}
