import 'package:eds_test/constants/config.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<String?> rawListOfUsers() async {
    final response = await http.get(Uri.parse('$apiUrl/users'));
    return response.statusCode == 200 ? response.body : null;
  }
}
