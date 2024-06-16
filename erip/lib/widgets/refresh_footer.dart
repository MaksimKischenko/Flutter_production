import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets.dart';

class RefreshFooter extends StatelessWidget {
  final String noDataMessage;

  const RefreshFooter({
    this.noDataMessage = 'Данных больше нет'
  });
  @override
  Widget build(BuildContext context) => CustomFooter(
    builder: (context, mode){
      Widget body;
      if (mode == LoadStatus.idle) {
        body = const Text('Загрузить еще');
      }
      else if (mode == LoadStatus.loading) {
        body = const LoadingIndicator();
      }
      else if (mode == LoadStatus.failed) {
        body = const Text('Ошибка связи с сервером');
      }
      else if (mode == LoadStatus.canLoading) {
        body = const Text('Отпустите, чтобы загрузить еще');
      } else {
        body = Text(noDataMessage);
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(child: body),
      );
    }
  );
}