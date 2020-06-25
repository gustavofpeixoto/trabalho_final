import 'dart:async';

import 'package:flutter/material.dart';
import 'package:App/app/modules/home/create/create_patient_bloc.dart';
import 'package:App/app/modules/home/home_module.dart';
import 'package:App/app/models/patient.dart';
import 'package:uuid/uuid.dart';

class CreatePatientPage extends StatefulWidget {
  final Function onSuccess;

  const CreatePatientPage({Key key, this.onSuccess}) : super(key: key);
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePatientPage> {
  var bloc = HomeModule.to.getBloc<CreatePatientBloc>();
  var uuid = Uuid();
  Controller controller;

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        centerTitle: true,
      ),
      body: StreamBuilder<int>(
          stream: bloc.responseOut,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Center(child: Text("${snapshot.error}",style: TextStyle(fontSize: 25)));

            if (snapshot.hasData) {
              if (snapshot.data == 0) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else{
                Timer(Duration(seconds: 1), (){
                   Navigator.pop(context);
                });
                return Center(child: Text("Inserido com sucesso!",style: TextStyle(fontSize: 25),));
              }
            
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            onSaved: (value) => bloc.active = value,
                            decoration: InputDecoration(labelText: "Ativo?"),
                          ),
                          TextFormField(
                            onSaved: (value) => bloc.bloodType = value,
                            validator: (value) => value.isEmpty
                                ? "O campo tipo sanguíneo não pode ser nulo"
                                : null,
                            decoration: InputDecoration(labelText: "Tipo Sanguíneo"),
                            maxLength: 100,
                          ),
                          TextFormField(
                            onSaved: (value) => bloc.name = value,
                            validator: (value) => value.isEmpty
                                ? "O campo nome não pode ser nulo"
                                : null,
                            decoration: InputDecoration(labelText: "Nome"),
                            maxLength: 10,
                          ),
                          TextFormField(
                            onSaved: (value) => bloc.yearsOld = value,
                            validator: (value) => value.isEmpty
                                ? "O campo idade não pode ser nulo"
                                : null,
                            maxLength: 100,
                            decoration: InputDecoration(labelText: "Idade"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        "Enviar",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (controller.validate()) {
                          bloc.postIn.add(Patient(
                              active: bloc.active, 
                              bloodType: bloc.bloodType,
                              name: bloc.name,
                              yearsOld: bloc.yearsOld,
                              id: uuid.v1().toString()));
                        }
                      },
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}