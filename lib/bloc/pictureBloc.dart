import 'package:rxdart/rxdart.dart';

import 'package:honeyaa_clientside/models/repository/repository.dart';

class PictureBloc {
  Repository _repo = Repository();

  final _picture = PublishSubject<String>(); 

  Observable<String> get picture => _picture.stream;

  getPicture(int id) async {
    String picture = await _repo.getPicture(id);

    _picture.sink.add(picture) ; 
  }

    dispose() {
    _picture.close();
  }
}

final pictureBloc = PictureBloc();