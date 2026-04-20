import 'package:flutter/material.dart';

import '../models/news_item.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(item.title, style: theme.textTheme.titleMedium),
        subtitle: Text(item.summary, style: theme.textTheme.bodyMedium),
        trailing: Text(
          '${item.publishedAt.hour.toString().padLeft(2, '0')}:${item.publishedAt.minute.toString().padLeft(2, '0')}',
          style: theme.textTheme.labelMedium,
        ),
      ),
    );
  }
}
