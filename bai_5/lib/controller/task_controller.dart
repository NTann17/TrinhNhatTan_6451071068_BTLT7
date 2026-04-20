import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskController {
  TaskController({TaskService? taskService}) : _taskService = taskService ?? TaskService();

  final TaskService _taskService;

  List<TaskModel> initialTasks() {
    return const [
      TaskModel(id: 1, title: 'Chuẩn bị bài học Flutter', description: 'Ôn lại widget cơ bản và state management'),
      TaskModel(id: 2, title: 'Làm bài tập DELETE API', description: 'Xoá task khỏi danh sách bằng http.delete()'),
      TaskModel(id: 3, title: 'Kiểm tra giao diện', description: 'Đảm bảo Snackbar hiển thị đúng khi xoá thành công'),
      TaskModel(id: 4, title: 'Cập nhật tài liệu', description: 'Ghi chú lại cấu trúc thư mục lib theo module'),
    ];
  }

  Future<void> deleteTask(int taskId) {
    return _taskService.deleteTask(taskId);
  }
}