import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/networking/ApiProvider.dart';

class Repository {
  ApiProvider apiProvider = ApiProvider();

  Future<User> fetchUser(int id) => apiProvider.fetchUser(id);
}