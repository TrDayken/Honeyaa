import 'package:rxdart/rxdart.dart';

import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/models/repository/repository.dart';

class UserBloc {
  Repository _repo = Repository();

  final _user = PublishSubject<User>();

  Observable<User> get user => _user.stream;

  getUser(int id) async {
    User user = await _repo.getUser(id);

    _user.sink.add(user);
  }

  dispose() {
    _user.close();
  }
}

// create a final for further access from other code
final userBloc = UserBloc();

