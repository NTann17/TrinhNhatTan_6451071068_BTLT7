## 📱 Product Detail App - Hướng Dẫn Thiết Kế

### 📂 Cấu trúc Thư mục (Clean Architecture)

```
lib/
├── main.dart                 # Entry point của ứng dụng
├── models/
│   └── product_model.dart    # Product model với fromJson()
├── services/
│   └── product_service.dart  # API service (gọi API, xử lý error)
├── views/
│   └── product_detail_view.dart    # Screen chính (FutureBuilder)
├── widgets/
│   └── product_detail_widget.dart  # Widget hiển thị chi tiết sản phẩm
└── utils/
    └── constants.dart        # Constants (API URL, timeout, v.v.)
```

### ✨ Tính Năng Chính

✅ **FutureBuilder** - Xử lý async data từ API  
✅ **Column** - Layout chi tiết sản phẩm  
✅ **Loading State** - Hiển thị progress indicator  
✅ **Error Handling** - Xử lý lỗi và hiển thị thông báo  
✅ **JSON Parsing** - Model Product.fromJson()  
✅ **Responsive UI** - Thích ứng mọi màn hình  

### 🔧 Chi Tiết Từng Component

#### 1. **ProductModel** (`models/product_model.dart`)
- Định nghĩa cấu trúc sản phẩm
- Method `fromJson()` để parse JSON từ API
- Method `toJson()` để chuyển object thành JSON

```dart
Product.fromJson(jsonData)  // Parse JSON → Product object
```

#### 2. **ProductService** (`services/product_service.dart`)
- Gọi API qua HTTP GET
- Xử lý timeout (10 giây)
- Xử lý các loại lỗi: network, timeout, server error
- Trả về Product object hoặc throw exception

```dart
ProductService.fetchProductDetail(productId)
```

#### 3. **ProductDetailView** (`views/product_detail_view.dart`)
- Screen chính hiển thị chi tiết sản phẩm
- **FutureBuilder** xử lý 3 state: loading, error, success
- Nút "Thử lại" khi có lỗi

**3 States trong FutureBuilder:**
```
┌─────────────────────┐
│   Loading State      │ → Hiển thị CircularProgressIndicator
├─────────────────────┤
│   Error State        │ → Hiển thị error message + nút retry
├─────────────────────┤
│   Success State      │ → Hiển thị ProductDetailWidget
└─────────────────────┘
```

#### 4. **ProductDetailWidget** (`widgets/product_detail_widget.dart`)
- Widget reusable hiển thị chi tiết sản phẩm
- Column chứa: ảnh, danh mục, tiêu đề, đánh giá, giá, mô tả
- Image error handling - hiển thị icon khi ảnh không tải được
- Nút "Thêm vào giỏ hàng"

#### 5. **Constants** (`utils/constants.dart`)
- API base URL (fake store API)
- Timeout duration (10 giây)
- App title

### 🚀 Cách Sử Dụng

#### Chạy ứng dụng:
```bash
flutter pub get
flutter run
```

#### Xem chi tiết sản phẩm khác:
```dart
// Ở main.dart, thay đổi productId
const ProductDetailView(productId: 5)
```

#### Kết nối với API khác:
Cập nhật `ApiConstants.baseUrl` trong `utils/constants.dart`

### 📡 Flow API Call

```
FutureBuilder
    ↓
ProductService.fetchProductDetail()
    ↓
API: GET https://fakestoreapi.com/products/1
    ↓
Parse JSON → Product.fromJson()
    ↓
Return Product hoặc Exception
    ↓
FutureBuilder render UI (loading/error/success)
```

### 🎨 UI States

| State | Widget | Icon |
|-------|--------|------|
| **Loading** | CircularProgressIndicator | ⏳ |
| **Error** | Error message + Retry button | ❌ |
| **Success** | ProductDetailWidget | ✅ |
| **Image Error** | Fallback icon | 🖼️ |

### 🔗 Dependencies

- `flutter` - Framework chính
- `http: ^1.1.0` - HTTP client để gọi API

### 📝 Ví dụ JSON Response từ API

```json
{
  "id": 1,
  "title": "Fjallraven Backpack",
  "price": 109.95,
  "description": "Your perfect pack for...",
  "image": "https://fakestoreapi.com/image.jpg",
  "category": "electronics",
  "rating": 3.9
}
```

### ✅ Checklist Tính Năng

- [x] Model Product với fromJson()
- [x] API Service gọi HTTP GET
- [x] FutureBuilder xử lý 3 states
- [x] Loading indicator
- [x] Error handling + retry button
- [x] JSON parsing
- [x] Responsive Column layout
- [x] Image error handling
- [x] Constants management
- [x] Clean Architecture

### 🐛 Troubleshooting

**Lỗi: "Lỗi kết nối"**
→ Kiểm tra internet connection hoặc firewall

**Lỗi: "Kết nối bị timeout"**
→ API chậm, tăng timeout duration trong constants.dart

**Ảnh không hiển thị**
→ Widget đã có error handler, sẽ hiển thị icon fallback

---

**🎓 Kiến thức Học Được:**
- Clean Architecture (models, services, views, widgets)
- FutureBuilder & async programming
- Error handling & state management
- JSON parsing
- HTTP API calls
- Responsive UI design
