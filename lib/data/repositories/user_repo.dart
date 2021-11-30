import 'package:eds_test/data/models/user.dart';
import 'package:eds_test/data/providers/user_api.dart';

class UserRepository {
  final _api = UserApi();

  Future<List<User>> users() async {
    final data = await _api.rawListOfUsers();
    return data != null ? User.fromList(data) : [];
  }
}
