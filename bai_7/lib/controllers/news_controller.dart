import 'package:flutter/foundation.dart';

import '../models/news_item.dart';
import '../utils/news_api_service.dart';

class NewsController extends ChangeNotifier {
  NewsController({NewsApiService? apiService})
    : _apiService = apiService ?? NewsApiService();

  final NewsApiService _apiService;

  List<NewsItem> _items = const [];
  bool _isLoading = false;

  List<NewsItem> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> loadNews() async {
    _isLoading = true;
    notifyListeners();

    final data = await _apiService.fetchNews();
    _items = data;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshNews() async {
    final data = await _apiService.fetchNews();
    _items = data;
    notifyListeners();
  }
}
