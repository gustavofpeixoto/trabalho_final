import 'package:App/app/models/patient.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:App/app/modules/home/home_repository.dart';

class HomeBloc extends BlocBase {
  
  final HomeRepository _repository;

  HomeBloc(this._repository);

  var patients = BehaviorSubject<List<Patient>>();
  Sink<List<Patient>> get responseIn => patients.sink;
  Stream<List<Patient>> get responseOut => patients.stream;

  void getPatient() async{
    try{
      var response = await _repository.getPatients();
      responseIn.add(response);
    }catch(err){
      patients.addError(err);
    }
  }

  @override
  void dispose() {
    patients.close();
    super.dispose();
  }
}
