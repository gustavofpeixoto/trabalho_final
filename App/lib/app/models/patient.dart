import 'package:App/app/models/address.dart';

class Patient {
  String id;
  String active;
  String bloodType;
  String name;
  String yearsOld;
  Address address;

  Patient
  ({
    this.id,
    this.active,
    this.bloodType, 
    this.name, 
    this.yearsOld, 
    this.address 
  });

  Patient.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    bloodType = json['bloodType'];
    name = json['name'];
    yearsOld = json['yearsOld'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['bloodType'] = this.bloodType;
    data['name'] = this.name;
    data['yearsOld'] = this.yearsOld;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}