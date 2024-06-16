import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';


class NotificationMethodScreen extends StatefulWidget {
  static const pageRoute = '/settings/notification_method';
  final String? currentNotificationMethodName;

  const NotificationMethodScreen({
    required this.currentNotificationMethodName,
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationMethodScreen> createState() => _NotificationMethodScreenState();
}

class _NotificationMethodScreenState extends State<NotificationMethodScreen> {
  late ScrollController _scrollController;

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          leading: ArrowBack(),
          title: _showTitle
              ? Text(
                  context.t.mobileScreens.settings.sections.notificationMethod.title,
                  style: const TextStyle(
                    color: AppStyles.mainColorDark,
                  ),
                )
              : null,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: FullScreen(
          bottomSafe: false,
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                child: PageTitle(
                  text: context.t.mobileScreens.settings.sections.notificationMethod.title,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: NotificationMethodTypes.values.length,
                itemBuilder: (context, index) => NotificationItem(
                  currentNotificationMethodName: widget.currentNotificationMethodName,
                  value: NotificationMethodTypes.values[index].typeName,
                  onTap: (value) {
                    if(value == NotificationMethodTypes.sms.typeName) {
                      Multiplatform.showDecisionMessage(
                        context: context, 
                        message: 'Текст1', 
                        action: () => Navigator.of(context).pop(value), 
                        dialogTitle: 'Текст1', 
                        buttonTitle: 'Ок', 
                        cancelButtonTitle: 'Отмена'
                      );
                    } else {
                      Navigator.of(context).pop(value);
                    }
                  }
                ),
                separatorBuilder: (context, _) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    color: AppStyles.mainColor.withOpacity(.1),
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
}
