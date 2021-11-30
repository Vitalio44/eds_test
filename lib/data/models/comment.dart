import 'dart:convert';

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  Map<String, dynamic> toMap(bool includeId) {
    return {
      'postId': postId,
      if (includeId) 'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      postId: int.tryParse(map['postId'].toString())!,
      id: map['id'],
      name: map['name'],
      email: map['email'],
      body: map['body'],
    );
  }

  static List<Comment> fromList(String source) {
    final posts = json.decode(source) as List;
    return posts
        .map((comment) => Comment(
              postId: int.tryParse(comment['postId'].toString())!,
              id: comment['id'],
              name: comment['name'],
              email: comment['email'],
              body: comment['body'],
            ))
        .toList();
  }

  String toJson([bool includeId = true]) => json.encode(toMap(includeId));

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));
}
