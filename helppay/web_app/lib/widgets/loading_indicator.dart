import 'package:flutter/cupertino.dart';

class LoadingIndicator extends StatelessWidget {
  
  const LoadingIndicator({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) => const CupertinoActivityIndicator();
}