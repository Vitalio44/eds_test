import 'dart:convert';

import 'package:eds_test/data/models/album.dart';
import 'package:eds_test/data/providers/album_api.dart';
import 'package:eds_test/data/repositories/photo_repo.dart';

class AlbumRepository {
  final _api = AlbumApi();
  final _photoRepo = PhotoRepository();

  Future<List<Album>> userAlbums(int userId) async {
    final data = await _api.rawUserAlbums(userId);
    if (data != null) {
      final dataMap = jsonDecode(data) as List;
      final albumPhotos = await _photoRepo.albumPhotos(dataMap.first['id']);
      return dataMap
          .map((e) => Album.fromMap(
                e,
                albumPhotos.isNotEmpty ? albumPhotos.first : null,
              ))
          .toList();
    } else {
      return <Album>[];
    }
  }
}
