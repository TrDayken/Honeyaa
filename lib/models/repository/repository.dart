import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/networking/ApiProvider.dart';
import 'package:rxdart/rxdart.dart';

class Repository {
  ApiProvider apiProvider = ApiProvider();

  Future<User> getUser(int id) => apiProvider.getUser(id);

  Future<String> getPicture(int id) => apiProvider.getPicture(id);

  Future<String> getID(String uid) => apiProvider.getID(uid) ; 

  Future<List<User>> getListUser(int id ) => apiProvider.getSwipe(id) ; 

  Future<List<User>> getLikedUser(int id) => apiProvider.getliked(id);
}