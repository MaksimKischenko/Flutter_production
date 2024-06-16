import 'package:flutter/material.dart';

class WebConstrainedBox extends StatelessWidget {
  final Widget child;
  const WebConstrainedBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(40),
    child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: child,
          ),
        ),
  );
}
