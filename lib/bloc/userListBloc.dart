import 'package:rxdart/rxdart.dart';

import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/models/repository/repository.dart';

class ListUserBloc {
  Repository _repo = Repository();

  final _listuser = PublishSubject<List<User>>();

  Observable<List<User>> get listuser => _listuser.stream;

  getListUser() async {
    List<User> listuser = await _repo.getListUser(5);

    _listuser.sink.add(listuser);
  }

  getLikedUser() async {
    List <User> listuser = await _repo.getLikedUser(5);

    _listuser.sink.add(listuser);
  }

  dispose() {
    _listuser.close();
  }

}

final listuserBloc = ListUserBloc() ; 