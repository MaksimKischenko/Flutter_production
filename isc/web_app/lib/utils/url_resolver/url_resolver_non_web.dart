import 'package:flutter/material.dart';

String getAbsolutePath(BuildContext context) => ModalRoute.of(context)?.settings.name ?? '';