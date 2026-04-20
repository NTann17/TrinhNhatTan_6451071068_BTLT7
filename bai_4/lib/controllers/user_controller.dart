import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserController extends ChangeNotifier {
  User? _user;
  User? _updatedUser;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get user => _user;
  User? get updatedUser => _updatedUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load thông tin user từ API
  Future<void> loadUser(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await UserService.getUser(userId);
      _updatedUser = _user?.copyWith(); // Sao chép để chỉnh sửa
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _user = null;
      _updatedUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Cập nhật tên
  void updateName(String value) {
    _updatedUser = _updatedUser?.copyWith(name: value);
    notifyListeners();
  }

  // Cập nhật email
  void updateEmail(String value) {
    _updatedUser = _updatedUser?.copyWith(email: value);
    notifyListeners();
  }

  // Cập nhật phone
  void updatePhone(String value) {
    _updatedUser = _updatedUser?.copyWith(phone: value);
    notifyListeners();
  }

  // Cập nhật address
  void updateAddress(String value) {
    _updatedUser = _updatedUser?.copyWith(address: value);
    notifyListeners();
  }

  // Gửi cập nhật lên server
  Future<bool> submitUpdate(int userId) async {
    if (_updatedUser == null) return false;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await UserService.updateUser(userId, _updatedUser!);
      _user = result; // Cập nhật dữ liệu hiển thị
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset form
  void resetForm() {
    _updatedUser = _user?.copyWith();
    _errorMessage = null;
    notifyListeners();
  }
}
