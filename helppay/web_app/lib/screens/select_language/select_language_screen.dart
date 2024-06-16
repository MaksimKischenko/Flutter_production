import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class SelectLanguageScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/settings_language');

  static const pageRoute = '/settings/language';

  const SelectLanguageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
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
                  context.t.mobileScreens.selectLanguage.title,
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
                  text: context.t.mobileScreens.selectLanguage.title,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppLocale.values.length,
                itemBuilder: (context, index) => LanguageItem(
                    value: AppLocale.values[index],
                    onTap: (value) {
                      AutoRouter.of(context).pop(value);
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
