import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

class PostController {
  // Controllers for input fields
  final TextEditingController contentController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  // State management
  bool isLoading = false;
  String? successMessage;
  String? errorMessage;
  Post? createdPost;

  /// Validate input fields
  bool validateInputs() {
    if (contentController.text.trim().isEmpty ||
        authorController.text.trim().isEmpty) {
      errorMessage = AppConstants.validationErrorMessage;
      return false;
    }
    errorMessage = null;
    return true;
  }

  /// Create post and send to server
  Future<bool> createPost() async {
    // Reset messages
    successMessage = null;
    errorMessage = null;

    // Validate inputs
    if (!validateInputs()) {
      return false;
    }

    isLoading = true;

    try {
      // Create Post object
      final post = Post(
        content: contentController.text.trim(),
        author: authorController.text.trim(),
      );

      // Call API service
      final result = await ApiService.createPost(post);

      if (result != null) {
        createdPost = result;
        successMessage = AppConstants.successMessage;
        print('📊 Created Post Data: $result');
        clearInputs();
        isLoading = false;
        return true;
      } else {
        errorMessage = AppConstants.errorMessage;
        isLoading = false;
        return false;
      }
    } catch (e) {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      isLoading = false;
      return false;
    }
  }

  /// Clear input fields
  void clearInputs() {
    contentController.clear();
    authorController.clear();
  }

  /// Clean up resources
  void dispose() {
    contentController.dispose();
    authorController.dispose();
  }
}
