import 'dart:async';

import '../models/news_item.dart';

class NewsApiService {
  Future<List<NewsItem>> fetchNews() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    final now = DateTime.now();

    return List<NewsItem>.generate(10, (index) {
      final itemNo = index + 1;
      return NewsItem(
        id: '${now.millisecondsSinceEpoch}-$itemNo',
        title: 'Tin nóng #$itemNo',
        summary:
            'Nội dung cập nhật lúc ${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}.',
        publishedAt: now.subtract(Duration(minutes: index * 5)),
      );
    });
  }
}
