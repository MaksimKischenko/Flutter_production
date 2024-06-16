import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHeader extends StatelessWidget {
  const RefreshHeader({
    Key? key,
  }): super(key: key);
  
  @override
  Widget build(BuildContext context) => defaultTargetPlatform == TargetPlatform.iOS
      ? ClassicHeader(
        idleText: context.t.widgets.refreshHeader.idle,
      )
      : const MaterialClassicHeader();
}