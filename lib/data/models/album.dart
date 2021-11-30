import 'dart:convert';

import 'package:eds_test/data/models/photo.dart';

class Album {
  final Photo? thumbnail;
  final int userId, id;
  final String title;

  Album(this.userId, this.id, this.title, [this.thumbnail]);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map, [Photo? photo]) {
    return Album(
      map['userId'],
      map['id'],
      map['title'],
      photo,
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));
}
