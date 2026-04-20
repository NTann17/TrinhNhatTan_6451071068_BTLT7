class ValidationUtils {
  // Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  // Validate phone
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại không được để trống';
    }
    if (value.length < 10) {
      return 'Số điện thoại phải ít nhất 10 chữ số';
    }
    return null;
  }

  // Validate name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tên không được để trống';
    }
    if (value.length < 2) {
      return 'Tên phải có ít nhất 2 ký tự';
    }
    return null;
  }

  // Validate address
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Địa chỉ không được để trống';
    }
    if (value.length < 5) {
      return 'Địa chỉ phải có ít nhất 5 ký tự';
    }
    return null;
  }
}
