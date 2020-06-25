import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:App/app/modules/home/home_repository.dart';
import 'package:App/app/models/address.dart';

class CreateAddressBloc extends BlocBase {
  final HomeRepository _repository;

  CreateAddressBloc(this._repository){
    responseOut = post.switchMap(observablePost);
  }

    String addressComplement; 
    String city; 
    String number; 
    String neighborhood;
    String publicPlace;
    String state;
    String zipCode;
    
  var post = BehaviorSubject<Address>();

  Address get postValue => post.value;
  Stream<int> responseOut;
  Sink<Address> get postIn => post.sink;

  Stream<int> observablePost(Address data) async* {
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