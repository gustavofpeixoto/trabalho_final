import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:App/app/modules/home/home_repository.dart';
import 'package:App/app/models/patient.dart';

class CreatePatientBloc extends BlocBase {
  final HomeRepository _repository;

  CreatePatientBloc(this._repository){
    responseOut = post.switchMap(observablePost);
  }

    String active;
    String bloodType;
    String name;
    String yearsOld;
    
  var post = BehaviorSubject<Patient>();

  Patient get postValue => post.value;
  Stream<int> responseOut;
  Sink<Patient> get postIn => post.sink;

  Stream<int> observablePost(Patient data) async* {
    yield 0;
    try{
    var response = await _repository.createAddress(data.toJson());
    yield response;
    }catch(e){
      throw e;
    }
  }

  @override
  void dispose() {
    post.close();
    super.dispose();
  }
}