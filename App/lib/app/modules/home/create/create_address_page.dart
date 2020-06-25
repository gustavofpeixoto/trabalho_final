import 'dart:async';

import 'package:App/app/modules/home/create/create_address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:App/app/modules/home/home_module.dart';
import 'package:App/app/models/address.dart';
import 'package:uuid/uuid.dart';

class CreateAddressPage extends StatefulWidget {
  final Function onSuccess;

  const CreateAddressPage({Key key, this.onSuccess}) : super(key: key);
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreateAddressPage> {
  var bloc = HomeModule.to.getBloc<CreateAddressBloc>();
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
                            onSaved: (value) => bloc.addressComplement = value,
                            decoration: InputDecoration(labelText: "Complemento"),
                            maxLength: 250,
                          ),
                          TextFormField(
                            onSaved: (value) => bloc.city = value,
                            validator: (value) => value.isEmpty
                                ? "O campo cidade não pode ser nulo"
                                : null,
                            decoration: InputDecoration(labelText: "Cidade"),
                            maxLength: 100,
                          ),
                          TextFormField(
                            onSaved: (value) => bloc.number = value,
                            validator: (value) => value.isEmpty
                                ? "O campo número não pode ser nulo"
                                : null,
                            decoration: InputDecoration(labelText: "Número"),
                            maxLength: 10,
                          ),
                          TextFormField(
                            onSaved: (value) => bloc.neighborhood = value,
                            validator: (value) => value.isEmpty
                                ? "O campo bairro não pode ser nulo"
                                : null,
                            maxLength: 100,
                            decoration: InputDecoration(labelText: "Bairro"),
                          ),
                          TextFormField(
                            onSaved: (value) => bloc.publicPlace = value,
                            validator: (value) => value.isEmpty
                                ? "O campo logradouro não pode ser nulo"
                                : null,
                            maxLength: 250,
                            decoration: InputDecoration(labelText: "Logradouro"),
                          ),
                          TextFormField(
                            onSaved: (value) => bloc.state = value,
                            validator: (value) => value.isEmpty
                                ? "O campo Estado não pode ser nulo"
                                : null,
                            maxLength: 75,
                            decoration: InputDecoration(labelText: "Estado"),
                          ),
                          TextFormField(
                            onSaved: (value) => bloc.zipCode = value,
                            validator: (value) => value.isEmpty
                                ? "O campo CEP não pode ser nulo"
                                : null,
                            maxLength: 8,
                            decoration: InputDecoration(labelText: "CEP"),
                          )
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
                          bloc.postIn.add(Address(
                              addressComplement: bloc.addressComplement, 
                              city: bloc.city,
                              number: bloc.number,
                              neighborhood: bloc.neighborhood,
                              publicPlace: bloc.publicPlace,
                              state: bloc.state,
                              zipCode: bloc.zipCode,
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