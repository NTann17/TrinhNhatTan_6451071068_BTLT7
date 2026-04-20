import 'package:flutter/material.dart';

import '../controllers/news_controller.dart';
import '../widgets/news_tile.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late final NewsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = NewsController();
    _controller.loadNews();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tin tuc')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading && _controller.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: _controller.refreshNews,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _controller.items.length,
              itemBuilder: (context, index) {
                final item = _controller.items[index];
                return NewsTile(item: item);
              },
            ),
          );
        },
      ),
    );
  }
}
