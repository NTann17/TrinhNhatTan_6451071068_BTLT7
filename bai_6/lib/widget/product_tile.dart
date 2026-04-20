import 'package:bai_6/models/product.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: product.thumbnail.isEmpty
            ? const CircleAvatar(child: Icon(Icons.image_not_supported_outlined))
            : CircleAvatar(backgroundImage: NetworkImage(product.thumbnail)),
        title: Text(product.title),
        subtitle: Text(
          product.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text('\$${product.price}'),
      ),
    );
  }
}
