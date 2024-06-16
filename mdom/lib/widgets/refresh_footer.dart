import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets.dart';

class RefreshFooter extends StatelessWidget {
  final String noMoreDataMessage;

  const RefreshFooter({
    this.noMoreDataMessage = 'Данных больше нет'
  });
  
  @override
  Widget build(BuildContext context) => CustomFooter(
    builder: (context, mode){
      Widget body;
      if (mode == LoadStatus.idle) {
        body = const Text('Загрузить еще');
      } else if (mode == LoadStatus.loading) {
        body = const SizedBox(
          width: 24,
          height: 24,
          child: LoadingIndicator(),
        );
      } else if (mode == LoadStatus.failed) {
        body = const Text('Ошибка связи с сервером');
      } else if (mode == LoadStatus.canLoading) {
        body = const Text('Отпустите, чтобы загрузить еще');
      } else {
        body = Text(noMoreDataMessage);
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(child: body),
      );
    }
  );
}