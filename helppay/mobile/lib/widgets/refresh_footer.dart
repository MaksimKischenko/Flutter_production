import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets.dart';

class RefreshFooter extends StatelessWidget {
  final String? noMoreDataMessage;
  final Function()? onTap;

  const RefreshFooter({
    this.noMoreDataMessage,
    this.onTap
  });
  
  @override
  Widget build(BuildContext context) => CustomFooter(
    builder: (context, mode){
      Widget? body;
      if (mode == LoadStatus.idle) {
        body = Text(context.t.widgets.refreshFooter.statuses.idle);
      }
      else if (mode == LoadStatus.loading) {
        body = const LoadingIndicator();
      }
      else if (mode == LoadStatus.failed) {
        body = Text(context.t.widgets.refreshFooter.statuses.failed);
      }
      else if (mode == LoadStatus.canLoading) {
        body = Text(context.t.widgets.refreshFooter.statuses.canLoading);
      } 
      else if (mode == LoadStatus.noMore ){
        body = Text(noMoreDataMessage ?? context.t.widgets.refreshFooter.statuses.noMoreData);
      }
      return GestureDetector(
        onTap: mode == LoadStatus.idle? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(child: body),
        ),
      );
    }
  );
}