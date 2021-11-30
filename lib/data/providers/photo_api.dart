import 'package:eds_test/constants/config.dart';
import 'package:http/http.dart' as http;

class PhotoApi {
  Future<String?> rawAlbumPhotos(int albumId) async {
    final response = await http.get(Uri.parse(
      '$apiUrl/photos?albumId=$albumId',
    ));
    return response.statusCode == 200 ? response.body : null;
  }
}
