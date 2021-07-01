import 'package:honeyaa_clientside/models/id.dart';
import 'package:rxdart/rxdart.dart';

import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/models/repository/repository.dart';

class ListUserBloc {
  Repository _repo = Repository();

  final _listuser = PublishSubject<List<User>>();

  Observable<List<User>> get listuser => _listuser.stream;

  getListUser(int id) async {
    List<User> listuser = await _repo.getListUser(id);

    _listuser.sink.add(listuser);
  }

  getLikedUser(int id) async {
    List <User> listuser = await _repo.getLikedUser(id);

    _listuser.sink.add(listuser);
  }

  dispose() {
    _listuser.close();
  }

}

final listuserBloc = ListUserBloc() ; 