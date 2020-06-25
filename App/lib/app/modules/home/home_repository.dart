import 'package:App/app/models/address.dart';
import 'package:App/app/models/patient.dart';
import 'package:App/app/shared/custom_dio/custom_dio.dart';
import 'package:dio/dio.dart';

class HomeRepository{
  final CustomDio _client;
  HomeRepository(this._client);

  Future<List<Address>> getAddresses() async{
    try{
      var response = await _client.get("/api/Address/Addresses");
      return (response.data as List).map((item) => Address.fromJson(item)).toList();
    } on DioError catch(err){
      throw(err.message);
    }
  }

  Future<int> createAddress(Map<String, dynamic> data) async{
    try{
      var response = await _client.post("/api/Address/Address", data: data);
      return response.statusCode;
    } on DioError catch(err){
      throw(err.message);
    }
  }

  Future<List<Patient>> getPatients() async{
    try{
      var response = await _client.get("/api/Patients/Patients");
      return (response.data as List).map((item) => Patient.fromJson(item)).toList();
    } on DioError catch(err){
      throw(err.message);
    }
  }

  Future<int> createPatient(Map<String, dynamic> data) async{
    try{
      var response = await _client.post("/api/Patients/Patient", data: data);
      return response.statusCode;
    } on DioError catch(err){
      throw(err.message);
    }
  }
}