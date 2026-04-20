import 'dart:convert';

class Post {
  final int? id;
  final String content;
  final String author;
  final DateTime? createdAt;

  Post({
    this.id,
    required this.content,
    required this.author,
    this.createdAt,
  });

  // Convert Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'author': author,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Create Post object from JSON response
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      content: json['content'] as String,
      author: json['author'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  // Convert Post to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  @override
  String toString() {
    return 'Post(id: $id, content: $content, author: $author, createdAt: $createdAt)';
  }
}
