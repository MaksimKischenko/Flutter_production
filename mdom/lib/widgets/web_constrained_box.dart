import 'package:flutter/material.dart';

class WebConstrainedBox extends StatelessWidget {
  final Widget child;
  const WebConstrainedBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 60,
            maxWidth: 720,
          ),
          child: child,
        ),
      );
}
