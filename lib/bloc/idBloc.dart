import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

import 'package:honeyaa_clientside/models/User.dart';
import 'package:honeyaa_clientside/models/repository/repository.dart';

class IDBloc {
  Repository _repo = Repository();

  final _id = PublishSubject<String>() ; 

  Observable<String> get id => _id.stream; 

  getid(String uid ) async {
    String id = await _repo.getID(uid);

    _id.sink.add(id) ; 
  }

  dispose() {
    _id.close();
  }
}

final idBloc = IDBloc() ; 