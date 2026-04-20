import '../models/user.dart';
import '../services/user_service.dart';

class UserController {
  /// Get danh sách user
  /// Được gọi bởi FutureBuilder
  static Future<List<User>> getUserList() async {
    return await UserService.fetchUserList();
  }

  /// Get user theo ID
  static Future<User> getUserById(int id) async {
    return await UserService.fetchUserById(id);
  }
}
