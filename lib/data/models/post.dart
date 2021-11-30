import 'dart:convert';

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post(this.id, this.userId, this.title, this.body);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      map['id'],
      map['userId'],
      map['title'],
      map['body'],
    );
  }

  static List<Post> fromList(String source) {
    final posts = json.decode(source) as List;
    return posts
        .map((post) => Post(
              post['id'],
              post['userId'],
              post['title'],
              post['body'],
            ))
        .toList();
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
