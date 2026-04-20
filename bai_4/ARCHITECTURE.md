# Bài 4: Update User Info (PUT API)

## 📁 Cấu trúc thư mục

```
lib/
├── main.dart                 # Entry point của ứng dụng
├── models/
│   └── user.dart            # Model User với fromJson, toJson, copyWith
├── services/
│   └── user_service.dart    # API service (GET, PUT)
├── controllers/
│   └── user_controller.dart # Business logic (ChangeNotifier)
├── views/
│   └── update_user_screen.dart # Main screen UI
├── widgets/
│   ├── custom_text_field.dart  # Custom TextField widget
│   ├── loading_widget.dart     # Loading indicator
│   └── error_widget.dart       # Error display
└── utils/
    └── validation_utils.dart   # Validation functions
```

## 🎯 Tính năng chính

### 1. **Load dữ liệu cũ (GET)**
- `UserService.getUser()` - Lấy thông tin user từ API
- `UserController.loadUser()` - Quản lý loading state

### 2. **Form chỉnh sửa**
- TextFormField với validation
- Hiển thị dữ liệu cũ để user so sánh
- Validation email, phone, name, address

### 3. **Cập nhật (PUT)**
- `UserService.updateUser()` - Gửi PUT request
- `UserController.submitUpdate()` - Xử lý submission
- Timeout 10 giây

### 4. **User Experience**
- ✅ SnackBar báo thành công (màu xanh)
- ❌ SnackBar báo lỗi (màu đỏ)
- Loading state khi xử lý
- Hiển thị dữ liệu mới vs cũ
- Nút Hủy (Reset) và Lưu thay đổi

## 📦 Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  http: ^1.1.0        # HTTP requests
  provider: ^6.0.0    # State management
```

## 🚀 Cách sử dụng

### 1. Install dependencies
```bash
flutter pub get
```

### 2. Chạy ứng dụng
```bash
flutter run
```

### 3. Thay đổi API URL
Mở file `lib/services/user_service.dart` và thay đổi:
```dart
static const String baseUrl = 'https://api.example.com';
```

### 4. Thay đổi User ID
Ở `main.dart`, thay đổi:
```dart
const UpdateUserScreen(userId: 1),  // Thay 1 bằng ID khác
```

## 🏗️ Kiến trúc và Design Pattern

### **MVC Pattern:**
- **Model**: `User` class
- **View**: `UpdateUserScreen`
- **Controller**: `UserController`

### **State Management:**
- Sử dụng `Provider` (ChangeNotifier)
- Reactive UI updates

### **Best Practices:**
- Separation of concerns
- Reusable widgets
- Error handling
- Loading states
- Form validation
- JSON serialization

## 📝 Chi tiết từng file

### `models/user.dart`
- Model User với các field: id, name, email, phone, address, avatar
- `fromJson()`: Convert JSON → User object
- `toJson()`: Convert User object → JSON
- `copyWith()`: Tạo copy với modified fields

### `services/user_service.dart`
- `getUser(userId)`: GET request
- `updateUser(userId, user)`: PUT request
- Error handling & timeout

### `controllers/user_controller.dart`
- Extend `ChangeNotifier` để auto notify listeners
- Quản lý: user, updatedUser, isLoading, errorMessage
- Methods: loadUser(), updateName/Email/Phone/Address(), submitUpdate()

### `views/update_user_screen.dart`
- Form chính để nhập dữ liệu
- Consumer<UserController> để reactive updates
- Validation khi submit
- SnackBar notifications

### `widgets/`
- **CustomTextField**: TextFormField có style
- **LoadingWidget**: Circular progress
- **ErrorWidget**: Error display với Retry button

### `utils/validation_utils.dart`
- Email, Phone, Name, Address validation

## 🔄 Flow xử lý

```
1. initState() → loadUser(userId)
   ↓
2. GET /users/{userId} → User data
   ↓
3. Hiển thị dữ liệu cũ & form
   ↓
4. User chỉnh sửa → onChanged() → updateName/Email/Phone/Address()
   ↓
5. Validation & submit → submitUpdate()
   ↓
6. PUT /users/{userId} → Update trên server
   ↓
7. SnackBar success → Cập nhật UI
```

## 🔧 Tùy chỉnh

### Thêm field mới:
1. Thêm vào `User` model
2. Thêm method `update[FieldName]()` vào controller
3. Thêm TextFormField vào view
4. Thêm validation function vào utils

### Thay đổi URL API:
Đổi trong `user_service.dart`:
```dart
static const String baseUrl = 'https://your-api.com';
```

### Thay đổi theme:
Chỉnh sửa theme trong `main.dart`:
```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  ...
)
```

## 📊 API Response Format

**GET Response:**
```json
{
  "id": 1,
  "name": "Leanne Graham",
  "email": "Sincere@april.biz",
  "phone": "1-770-736-8031",
  "address": "Kulas Light"
}
```

**PUT Request:**
```json
{
  "id": 1,
  "name": "New Name",
  "email": "new@example.com",
  "phone": "0123456789",
  "address": "New Address"
}
```

## ✨ Ưu điểm của cấu trúc này

✅ Clean code - dễ bảo trì  
✅ Tái sử dụng được - dễ mở rộng  
✅ Decoupling - Model/View/Controller tách biệt  
✅ Error handling - toàn bộ flow  
✅ Loading states - UX tốt  
✅ Validation - data safety  
✅ Scalable - dễ thêm features mới
