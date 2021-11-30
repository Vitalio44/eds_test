import 'dart:convert';

import 'package:eds_test/data/models/photo.dart';
import 'package:eds_test/data/providers/photo_api.dart';

class PhotoRepository {
  final _api = PhotoApi();

  Future<List<Photo>> albumPhotos(int albumId) async {
    final data = await _api.rawAlbumPhotos(albumId);
    if (data != null) {
      final dataMap = jsonDecode(data) as List;
      return dataMap.map((e) => Photo.fromMap(e)).toList();
    } else {
      return <Photo>[];
    }
  }
}
