
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class SelectNotificationMethodScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/notification_method');

  static const pageRoute = '/settings/notification_method';
  final String currentNotificationMethodName;

  const SelectNotificationMethodScreen({
    required this.currentNotificationMethodName,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectNotificationMethodScreen> createState() =>
      _SelectNotificationMethodScreenState();
}

class _SelectNotificationMethodScreenState
    extends State<SelectNotificationMethodScreen> {
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
                  context.t.mobileScreens.settings.sections.notificationMethod
                      .title,
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
                  text: context.t.mobileScreens.settings.sections
                      .notificationMethod.title,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: NotificationMethodTypes.values.length,
                itemBuilder: (context, index) => NotificationItem(
                    value: NotificationMethodTypes.values[index].typeName,
                    currentNotificationMethodName:
                        widget.currentNotificationMethodName,
                    onTap: (value) {
                      if (value == NotificationMethodTypes.sms.typeName) {
                        Multiplatform.showDecisionMessage(
                            context: context,
                            message: 'Текст1',
                            action: () async {
                              await PreferencesHelper.write(
                                  PrefsKeys.notificationMethod, value);
                              await AutoRouter.of(context)
                                  .pushAndPopUntil<String>(const ProfileRoute(),
                                      predicate: (route) => false);
                            },
                            dialogTitle: 'Текст1',
                            buttonTitle: 'Ок',
                            cancelButtonTitle: 'Отмена');
                      } else {
                        AutoRouter.of(context).pop(value);
                      }
                    }),
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
