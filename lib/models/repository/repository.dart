import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/networking/ApiProvider.dart';

class Repository {
  ApiProvider apiProvider = ApiProvider();

  Future<User> getUser(int id) => apiProvider.getUser(id);
}