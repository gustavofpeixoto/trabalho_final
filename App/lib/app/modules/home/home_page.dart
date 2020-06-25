import 'package:App/app/models/address.dart';
import 'package:App/app/models/patient.dart';
import 'package:App/app/modules/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:App/app/modules/home/home_module.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  
  var bloc = HomeModule.to.getBloc<HomeBloc>();

  @override
  void initState() {
    bloc.getPatient();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
              child: StreamBuilder<List<Patient>>(
          stream:bloc.responseOut ,
          builder: (context, snapshot) {

            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }

            if(snapshot.hasData){
              return Column(children: snapshot.data.map((item) => ListTile(title: Text(item.name),)).toList());
            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          }
        ),
      ),
    );
  }
}
