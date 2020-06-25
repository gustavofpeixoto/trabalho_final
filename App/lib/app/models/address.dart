import 'package:App/app/models/patient.dart';

class Address{
  String id;
  String addressComplement;
  String city;
  String number;
  String neighborhood;
  Patient patient;
  String patientId;
  String publicPlace;
  String state;
  String zipCode;
  
  Address
  ({
    this.id,
    this.addressComplement, 
    this.city, 
    this.number, 
    this.neighborhood,
    this.patient, 
    this.patientId,
    this.publicPlace,
    this.state,
    this.zipCode
  });

  Address.fromJson(Map<String, dynamic> json){
    addressComplement = json['addressComplement'];
    city = json['city'];
    number = json['number'];
    neighborhood = json['neighborhood'];
    publicPlace = json['publicPlace'];
    state = json['state'];
    zipCode = json['zipCode'];
    patientId = json['patientId'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressComplement'] = this.addressComplement;
    data['city'] = this.city;
    data['number'] = this.number;
    data['neighborhood'] = this.neighborhood;
    data['publicPlace'] = this.publicPlace;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    data['patientId'] = this.patientId;
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}
