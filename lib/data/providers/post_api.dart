import 'package:eds_test/constants/config.dart';
import 'package:http/http.dart' as http;

class PostApi {
  Future<String?> rawUserPosts(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/posts?userId=$userId'));
    return response.statusCode == 200 ? response.body : null;
  }

  Future<String?> rawPostComments(int postId) async {
    final response = await http.get(Uri.parse(
      '$apiUrl/posts/$postId/comments',
    ));
    return response.statusCode == 200 ? response.body : null;
  }

  Future<String?> newPostComment(String data, int postId) async {
    final response = await http.post(
      Uri.parse('$apiUrl/posts/$postId/comments'),
      body: data,
      headers: {
        'Content-type': 'application/json',
      },
    );
    print('--> response');
    print(response.statusCode);
    print(response.body);
    return response.statusCode == 201 ? response.body : null;
  }
}
