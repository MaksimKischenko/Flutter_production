import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:payment_tracking_module/app.dart';
import 'package:payment_tracking_module/app_injector.dart';
import 'package:payment_tracking_module/app_wrapper.dart';

import 'presentation/bloc/simple_bloc_observer.dart';


Future<void> bootstrap() async {
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: HydratedStorage.webStorageDirectory);
  await AppInjector.run(); 
  Bloc.observer = SimpleBlocObserver();
  Bloc.transformer = sequential<dynamic>();    //выбиваем прошлый евент зпуска вебсокета и начинаем новый
  runApp(AppWrapper(child: App()));      
}

