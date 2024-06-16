import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MultiplatformIndicator extends StatelessWidget {
  
  const MultiplatformIndicator({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) => defaultTargetPlatform == TargetPlatform.iOS
      ? const CupertinoActivityIndicator()
      : const CircularProgressIndicator();
}