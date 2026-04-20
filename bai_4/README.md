# 📱 Bài 4: Update User Info (PUT API)

> Ứng dụng Flutter quản lý cập nhật thông tin người dùng - Cấu trúc tối ưu, Clean Code, Production Ready

## 🎯 Yêu cầu

✅ Load dữ liệu cũ (GET API)  
✅ Cho user chỉnh sửa thông tin  
✅ Gửi http.put() cập nhật  
✅ Hiển thị dữ liệu mới sau update  
✅ SnackBar báo thành công / lỗi  

## 📦 Công nghệ sử dụng

- **Framework**: Flutter 3.12+
- **State Management**: Provider (ChangeNotifier)
- **HTTP Client**: http package
- **Architecture**: MVC + Service-Controller pattern

## 🏗️ Cấu trúc dự án

```
lib/
├── main.dart                      # Entry point
├── exports.dart                   # Central exports
├── models/
│   └── user.dart                 # User data model
├── services/
│   └── user_service.dart         # API calls (GET, PUT)
├── controllers/
│   └── user_controller.dart      # Business logic
├── views/
│   └── update_user_screen.dart   # Main UI
├── widgets/
│   ├── custom_text_field.dart    # Reusable form field
│   ├── loading_widget.dart       # Loading indicator
│   └── error_widget.dart         # Error display
└── utils/
    └── validation_utils.dart     # Form validation
```

## 🚀 Quick Start

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run App
```bash
flutter run
```

### 3. Build APK/iOS
```bash
# Android
flutter build apk

# iOS
flutter build ios
```

## 📚 Tài liệu

| File | Mô tả |
|------|-------|
| [ARCHITECTURE.md](ARCHITECTURE.md) | Cấu trúc chi tiết & design patterns |
| [DETAILED_DOCS.md](DETAILED_DOCS.md) | Tài liệu kỹ thuật chi tiết |
| [SETUP.md](SETUP.md) | Hướng dẫn cài đặt & cấu hình |
| [TESTING.md](TESTING.md) | Test cases & scenarios |

## ✨ Tính năng chính

### 🔄 Load Data
```dart
// Tự động load user data khi app khởi động
_controller.loadUser(1);
```

### 📝 Edit Form
- TextFormField với validation realtime
- Hiển thị dữ liệu cũ vs mới
- Real-time UI updates

### 💾 Save Changes
```dart
// PUT request với error handling
final success = await controller.submitUpdate(1);
```

### 🎨 User Feedback
- ✅ Green SnackBar on success
- ❌ Red SnackBar on error
- Loading indicator during request
- Error screen with retry button

## 🔌 API Integration

### Base URL (mặc định)
```dart
https://jsonplaceholder.typicode.com
```

## ✅ Best Practices

✅ **Clean Architecture** - Separation of concerns  
✅ **Error Handling** - Try-catch everywhere  
✅ **Loading States** - Better UX  
✅ **Form Validation** - Data safety  
✅ **Reusable Widgets** - DRY principle  
✅ **Scalable** - Easy to add features  

---

**Happy Coding! 🚀**
