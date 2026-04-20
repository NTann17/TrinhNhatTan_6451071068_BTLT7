import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
import '../utils/validation_utils.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_widget.dart';
import 'package:bai_4/widgets/error_widget.dart' as error_widget;

class UpdateUserScreen extends StatefulWidget {
  final int userId;

  const UpdateUserScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late UserController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = context.read<UserController>();
    _controller.loadUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật thông tin'),
        elevation: 0,
      ),
      body: Consumer<UserController>(
        builder: (context, controller, _) {
          if (controller.isLoading && controller.user == null) {
            return LoadingWidget(message: 'Đang tải thông tin...');
          }

          if (controller.errorMessage != null && controller.user == null) {
            return error_widget.ErrorWidget(
              message: controller.errorMessage ?? 'Có lỗi xảy ra',
              onRetry: () => _controller.loadUser(widget.userId),
            );
          }

          if (controller.updatedUser == null) {
            return const Center(
              child: Text('Không có dữ liệu'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Dữ liệu cũ hiển thị
                  if (controller.user != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dữ liệu hiện tại:',
                              style:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8.0),
                            Text('Tên: ${controller.user!.name}'),
                            Text('Email: ${controller.user!.email}'),
                            Text('Điện thoại: ${controller.user!.phone}'),
                            Text('Địa chỉ: ${controller.user!.address}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                  ],

                  // Form chỉnh sửa
                  Text(
                    'Chỉnh sửa thông tin:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16.0),

                  CustomTextField(
                    label: 'Tên',
                    hint: 'Nhập tên đầy đủ',
                    initialValue: controller.updatedUser!.name,
                    onChanged: (value) => controller.updateName(value),
                    validator: ValidationUtils.validateName,
                  ),

                  CustomTextField(
                    label: 'Email',
                    hint: 'Nhập email',
                    initialValue: controller.updatedUser!.email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => controller.updateEmail(value),
                    validator: ValidationUtils.validateEmail,
                  ),

                  CustomTextField(
                    label: 'Số điện thoại',
                    hint: 'Nhập số điện thoại',
                    initialValue: controller.updatedUser!.phone,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => controller.updatePhone(value),
                    validator: ValidationUtils.validatePhone,
                  ),

                  CustomTextField(
                    label: 'Địa chỉ',
                    hint: 'Nhập địa chỉ',
                    initialValue: controller.updatedUser!.address,
                    maxLines: 3,
                    onChanged: (value) => controller.updateAddress(value),
                    validator: ValidationUtils.validateAddress,
                  ),

                  const SizedBox(height: 24.0),

                  // Nút thao tác
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controller.isLoading
                              ? null
                              : () => _controller.resetForm(),
                          child: const Text('Hủy'),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : () => _submitForm(context),
                          child: controller.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                  ),
                                )
                              : const Text('Lưu thay đổi'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),

                  // Thông tin sau khi cập nhật
                  if (controller.user != null &&
                      controller.updatedUser != null &&
                      (controller.user!.name != controller.updatedUser!.name ||
                          controller.user!.email !=
                              controller.updatedUser!.email ||
                          controller.user!.phone !=
                              controller.updatedUser!.phone ||
                          controller.user!.address !=
                              controller.updatedUser!.address))
                    Card(
                      color: Colors.blue.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dữ liệu mới:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.blue.shade800),
                            ),
                            const SizedBox(height: 8.0),
                            Text('Tên: ${controller.updatedUser!.name}'),
                            Text('Email: ${controller.updatedUser!.email}'),
                            Text('Điện thoại: ${controller.updatedUser!.phone}'),
                            Text('Địa chỉ: ${controller.updatedUser!.address}'),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final success =
          await _controller.submitUpdate(widget.userId);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Cập nhật thông tin thành công!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Đóng',
              onPressed: () {},
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_controller.errorMessage ??
                'Cập nhật thất bại, vui lòng thử lại'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
