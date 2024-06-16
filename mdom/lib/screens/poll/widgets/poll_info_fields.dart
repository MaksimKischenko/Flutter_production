import 'package:bpc/data/data.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets.dart';

class PollInfoFields extends StatelessWidget {
  final Poll poll;
  const PollInfoFields({
    super.key,
    required this.poll,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InfoItem(
            title: 'Собрание (опрос)',
            subtitle: poll.topic,
          ),
          InfoItem(title: 'Статус', subtitle: poll.status.name),
          if (poll.cancelDate.isNotNullorEmpty)
            InfoItem(
              title: 'Отмена',
              subtitle: poll.cancelDate!.toStringWithoutSeconds(),
            ),
          if (poll.startDate.isNotNullorEmpty)
            InfoItem(
              title: 'Начало',
              subtitle: poll.startDate!.toStringWithoutSeconds(),
            ),
          if (poll.stopDate.isNotNullorEmpty)
            InfoItem(
              title: 'Окончание',
              subtitle: poll.stopDate!.toStringWithoutSeconds(),
            ),
          if (poll.notificationDate.isNotNullorEmpty)
            InfoItem(
              title: 'Оповещение',
              subtitle: poll.notificationDate!.toStringWithoutSeconds(),
            ),
          InfoItem(
            title: 'Вид',
            subtitle: poll.anonymous == 1 ? 'Закрытое' : 'Открытое',
          ),
          if (poll.url.isNotNullorEmpty)
            InfoItem(
              title: 'Подробнее',
              subtitle: poll.url!,
              isUrl: true,
              onTap: () => launchUrl(Uri.parse(poll.url!)),
            ),
        ],
      );
}
