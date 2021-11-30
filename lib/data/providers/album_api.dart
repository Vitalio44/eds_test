import 'package:eds_test/constants/config.dart';
import 'package:http/http.dart' as http;

class AlbumApi {
  Future<String?> rawUserAlbums(int userId) async {
    final response = await http.get(Uri.parse(
      '$apiUrl/albums?userId=$userId',
    ));
    return response.statusCode == 200 ? response.body : null;
  }
}
