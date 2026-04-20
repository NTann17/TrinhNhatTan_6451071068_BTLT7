import 'package:http/http.dart' as http;

import '../utils/api_constants.dart';

class TaskService {
  Future<void> deleteTask(int taskId) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.taskBaseUrl}/$taskId'),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Không thể xoá task. Mã lỗi: ${response.statusCode}');
    }
  }
}