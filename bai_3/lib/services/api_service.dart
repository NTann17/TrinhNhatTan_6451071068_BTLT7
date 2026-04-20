import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../utils/constants.dart';

class ApiService {
  /// Create a new post using POST API
  /// Returns the created Post object or null if failed
  static Future<Post?> createPost(Post post) async {
    try {
      // Create JSON body
      final jsonBody = jsonEncode(post.toJson());

      print('📤 Sending POST request to: ${AppConstants.createPostEndpoint}');
      print('📝 Request body: $jsonBody');

      // Send POST request
      final response = await http
          .post(
            Uri.parse(AppConstants.createPostEndpoint),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonBody,
          )
          .timeout(AppConstants.apiTimeout);

      print('✅ Response status code: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      // Check if request was successful
      if (response.statusCode == 201 || response.statusCode == 200) {
        // Parse response and create Post object
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Post createdPost = Post.fromJson(responseData);

        print('🎉 Post created successfully: $createdPost');
        return createdPost;
      } else {
        print('❌ Error: Server returned status code ${response.statusCode}');
        return null;
      }
    } on http.ClientException catch (e) {
      print('❌ Network Error: $e');
      throw Exception(AppConstants.networkErrorMessage);
    } catch (e) {
      print('❌ Unexpected Error: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
