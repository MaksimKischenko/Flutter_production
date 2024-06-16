import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:payment_tracking_module/bootstrap.dart';


final getIt = GetIt.instance;
Timer timer = Timer(Duration.zero, () {});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
}
