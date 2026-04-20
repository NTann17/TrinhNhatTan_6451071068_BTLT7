import 'package:bai_6/controller/product_search_controller.dart';
import 'package:bai_6/utils/app_constants.dart';
import 'package:bai_6/utils/debouncer.dart';
import 'package:bai_6/widget/product_tile.dart';
import 'package:bai_6/widget/search_input.dart';
import 'package:flutter/material.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  late final ProductSearchController _controller;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _controller = ProductSearchController()..searchProducts('');
    _debouncer = Debouncer(delay: AppConstants.searchDebounce);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onKeywordChanged(String keyword) {
    _debouncer.run(() {
      _controller.searchProducts(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bai 6 - Search API')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SearchInput(onChanged: _onKeywordChanged),
            const SizedBox(height: 12),
            Expanded(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  if (_controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_controller.errorMessage != null) {
                    return Center(child: Text(_controller.errorMessage!));
                  }

                  if (_controller.products.isEmpty) {
                    return const Center(
                      child: Text('Khong co ket qua phu hop'),
                    );
                  }

                  return ListView.builder(
                    itemCount: _controller.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductTile(product: _controller.products[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
