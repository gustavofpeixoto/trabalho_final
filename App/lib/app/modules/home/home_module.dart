import 'package:App/app/modules/home/create/create_address_bloc.dart';
import 'package:App/app/modules/home/home_bloc.dart';
import 'package:App/app/modules/home/home_repository.dart';
import 'package:App/app/shared/custom_dio/custom_dio.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:App/app/modules/home/home_page.dart';

import '../../app_module.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(HomeModule.to.getDependency<HomeRepository>())),
        Bloc((i) => CreateAddressBloc(HomeModule.to.getDependency<HomeRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => HomeRepository(AppModule.to.getDependency<CustomDio>()))
  ];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
