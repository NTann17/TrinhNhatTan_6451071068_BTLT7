import 'package:flutter/material.dart';
import '../models/user.dart';
import '../controllers/user_controller.dart';
import '../widgets/user_card_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart' as custom_error;

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late Future<List<User>> _userListFuture;

  @override
  void initState() {
    super.initState();
    _userListFuture = UserController.getUserList();
  }

  /// Thử lại fetch dữ liệu
  void _retryFetch() {
    setState(() {
      _userListFuture = UserController.getUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Liên Hệ'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: FutureBuilder<List<User>>(
        future: _userListFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget(message: 'Đang tải danh sách liên hệ...');
          }

          // Error state
          if (snapshot.hasError) {
            return custom_error.ErrorWidget(
              message: snapshot.error.toString(),
              onRetry: _retryFetch,
            );
          }

          // No data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.people_outline,
                    color: Colors.grey,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Không có dữ liệu',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _retryFetch,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tải lại'),
                  ),
                ],
              ),
            );
          }

          // Success - display user list
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return UserCardWidget(user: users[index]);
            },
          );
        },
      ),
    );
  }
}
