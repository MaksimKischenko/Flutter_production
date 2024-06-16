import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';

/// tap outside to to dismiss focus
class CheckSessionWrapper extends StatelessWidget {
  final Widget child;

  const CheckSessionWrapper({
    required this.child
  });

  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: (e) {
      // print('onPointerDown');
      context.read<CheckSessionBloc>().add(CheckSessionUserInteraction());
    },
    child: child,
  );
}