import 'package:flutter/material.dart';

import '../controller/task_controller.dart';
import '../models/task_model.dart';
import '../utils/snackbar_utils.dart';
import '../widget/task_item.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TaskController _taskController = TaskController();
  late final List<TaskModel> _tasks;
  final Set<int> _deletingTaskIds = <int>{};

  @override
  void initState() {
    super.initState();
    _tasks = List<TaskModel>.of(_taskController.initialTasks());
  }

  Future<bool> _deleteTask(TaskModel task) async {
    if (_deletingTaskIds.contains(task.id)) {
      return false;
    }

    setState(() {
      _deletingTaskIds.add(task.id);
    });

    try {
      await _taskController.deleteTask(task.id);

      if (!mounted) {
        return true;
      }

      setState(() {
        _tasks.removeWhere((item) => item.id == task.id);
      });

      SnackbarUtils.showMessage(
        context,
        'Đã xoá "${task.title}" khỏi danh sách',
        backgroundColor: const Color(0xFF2A9D8F),
      );
      return true;
    } catch (error) {
      if (!mounted) {
        return false;
      }

      SnackbarUtils.showMessage(
        context,
        'Xoá task thất bại. Vui lòng thử lại.',
        backgroundColor: const Color(0xFFE63946),
      );
      return false;
    } finally {
      if (mounted) {
        setState(() {
          _deletingTaskIds.remove(task.id);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý task'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Vuốt sang trái hoặc bấm icon xoá để gọi DELETE API.',
                style: TextStyle(fontSize: 15, color: Color(0xFF4B5563)),
              ),
            ),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'Danh sách trống',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return Dismissible(
                          key: ValueKey(task.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE63946),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                          ),
                          confirmDismiss: (_) => _deleteTask(task),
                          child: TaskItem(
                            task: task,
                            isDeleting: _deletingTaskIds.contains(task.id),
                            onDelete: () {
                              _deleteTask(task);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}