import 'package:bai_6/views/product_search_page.dart';
import 'package:flutter/material.dart';

class Bai6App extends StatelessWidget {
  const Bai6App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bai 6 - Search API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ProductSearchPage(),
    );
  }
}
