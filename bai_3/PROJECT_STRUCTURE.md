# 📱 Create Post API - Flutter Application

## 📋 Cấu Trúc Dự Án

```
lib/
├── main.dart                 # Entry point của ứng dụng
├── models/
│   └── post_model.dart      # Model định nghĩa cấu trúc Post
├── services/
│   └── api_service.dart     # Service xử lý HTTP requests
├── controllers/
│   └── post_controller.dart # Business logic & state management
├── views/
│   └── create_post_view.dart # UI screen chính
├── widgets/
│   └── post_input_field.dart # Custom widget tái sử dụng
└── utils/
    └── constants.dart       # Constants & configurations
```

---

## 🏗️ Giải Thích Chi Tiết

### 1. **models/post_model.dart**
Định nghĩa cấu trúc dữ liệu Post:
- **Attributes**: id, content, author, createdAt
- **Methods**:
  - `toJson()`: Chuyển object thành JSON để gửi server
  - `fromJson()`: Parse JSON response từ server
  - `toJsonString()`: Convert thành JSON string

```dart
Post post = Post(
  content: "Hello World",
  author: "John Doe"
);
```

### 2. **services/api_service.dart**
Xử lý tất cả HTTP requests:
- **createPost()**: Gửi POST request tới server
- In chi tiết request/response vào console
- Handle errors & timeouts
- Trả về Post object hoặc null

```dart
final post = Post(content: "...", author: "...");
final result = await ApiService.createPost(post);
```

### 3. **controllers/post_controller.dart**
Business logic & state management:
- **TextEditingController**: Quản lý input từ user
- **validateInputs()**: Kiểm tra các field bắt buộc
- **createPost()**: Orchestrate việc tạo post
- **clearInputs()**: Xóa dữ liệu input
- Track: isLoading, successMessage, errorMessage, createdPost

### 4. **views/create_post_view.dart**
UI screen chính:
- **TextField**: Nhập Author Name & Post Content
- **ElevatedButton**: Nút tạo post
- **SnackBar**: Hiển thị thông báo (success/error)
- **AlertDialog**: Hiển thị chi tiết response từ server
- Responsive design với SingleChildScrollView

### 5. **widgets/post_input_field.dart**
Custom TextField widget tái sử dụng:
- `controller`: TextEditingController để quản lý text
- `label`: Nhãn hiển thị
- `hint`: Gợi ý text
- `maxLines`: Số dòng tối đa
- `prefixIcon`: Icon hiển thị trước text

### 6. **utils/constants.dart**
Tập trung quản lý constants:
- Base URL & API Endpoints
- Response messages
- API Timeout settings

### 7. **main.dart**
Entry point:
- Initialize MaterialApp
- Set theme & routing
- Load CreatePostView

---

## 🚀 Cách Sử Dụng

### Step 1: Cài đặt dependencies
```bash
flutter pub get
```

### Step 2: Chạy ứng dụng
```bash
flutter run
```

### Step 3: Nhập dữ liệu
1. Nhập Author Name (ví dụ: "John Doe")
2. Nhập Post Content (ví dụ: "Hello Flutter!")
3. Nhấn nút "Create Post"

### Step 4: Kiểm tra kết quả
- ✅ Nếu thành công: Hiển thị "Post created successfully"
- 📊 Chi tiết response sẽ hiện trong AlertDialog
- 🔍 Console sẽ in ra full request/response details

---

## 📤 Chi Tiết HTTP Request

**Method**: POST  
**URL**: `https://jsonplaceholder.typicode.com/posts`  
**Headers**: 
```
Content-Type: application/json
```

**Body (JSON)**:
```json
{
  "content": "Hello Flutter!",
  "author": "John Doe",
  "createdAt": "2026-04-20T10:30:00.000"
}
```

**Response (201 Created)**:
```json
{
  "id": 101,
  "content": "Hello Flutter!",
  "author": "John Doe",
  "createdAt": "2026-04-20T10:30:00.000"
}
```

---

## 🎯 Features

✅ **Structured Code**: Tách biệt Model, Service, Controller, View  
✅ **JSON Encoding**: Tự động encode object thành JSON  
✅ **Error Handling**: Xử lý lỗi network, validation, timeout  
✅ **User Feedback**: SnackBar & Dialog notifications  
✅ **Console Logging**: Chi tiết request/response debug info  
✅ **Reusable Components**: Custom PostInputField widget  
✅ **State Management**: PostController quản lý state  
✅ **Responsive UI**: Hoạt động trên mọi kích thước màn hình  

---

## 🔧 Cấu Hình API Endpoint

Để sử dụng server thực tế của bạn, chỉnh sửa trong `utils/constants.dart`:

```dart
static const String baseUrl = 'https://your-api.com';
static const String createPostEndpoint = '$baseUrl/api/posts';
```

---

## 🐛 Debugging

### Console Output
Ứng dụng in ra console:
```
📤 Sending POST request to: ...
📝 Request body: {...}
✅ Response status code: 201
📥 Response body: {...}
🎉 Post created successfully: ...
```

### Network Debugging
- Kiểm tra URL đúng không
- Verify JSON format
- Check server status
- Xem internet connection

---

## 📚 Best Practices Được Áp Dụng

1. **Separation of Concerns**: Tách Model, Service, Controller, View
2. **DRY Principle**: PostInputField tái sử dụng
3. **Error Handling**: Try-catch & user feedback
4. **Code Organization**: Folder structure rõ ràng
5. **Documentation**: Comments & logging
6. **Constants**: Tập trung manage constants
7. **Async/Await**: Modern async pattern

---

## 📝 Mở Rộng Thêm

### Thêm chức năng Edit Post:
1. Tạo `update_post_view.dart` với form edit
2. Thêm `updatePost()` method trong `ApiService`
3. Thêm PUT endpoint

### Thêm chức năng List Posts:
1. Tạo `posts_list_view.dart`
2. Thêm `getPosts()` method trong `ApiService`
3. Hiển thị danh sách posts

### Thêm authentication:
1. Tạo `auth_service.dart`
2. Lưu token sau login
3. Gửi token trong header requests

---

**Tác giả**: Generated by Flutter Best Practices  
**Version**: 1.0.0  
**Date**: 2026-04-20
