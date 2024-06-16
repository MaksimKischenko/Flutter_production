import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

@RoutePage()
class FeaturesScreen extends StatefulWidget {
  static const pageRoute = '/features';

  const FeaturesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  late List<FeatureData> _features;

  @override
  void initState() {
    super.initState();
    context.read<FeaturesBloc>().add(FeaturesInit());
    _features = [
      FeatureData(
          iconName: 'feature_profile',
          title: 'Профиль',
          subtitle: 'Информация о вашей организации',
          onTap: () {
            AutoRouter.of(context).push(const ProfileRoute());
          }

          // Navigation.toProfile,
          ),
      FeatureData(
          iconName: 'feature_settings',
          title: 'Настройки',
          subtitle: 'Вход и пароль',
          onTap: () async {
            await AutoRouter.of(context).push(const SettingsRoute());
          }
          // Navigation.toSettings,
          ),
      FeatureData(
        iconName: 'feature_help',
        title: 'Помощь',
        subtitle: 'Цвета требований и платежей',
        onTap: () async {
          await AutoRouter.of(context).push(const HelpRoute());
        },
        // Navigation.toHelp,
      ),
      FeatureData(
        iconName: 'feature_about',
        title: 'О приложении',
        onTap: () async {
          await AutoRouter.of(context).push(const AboutAppRoute());
        },
        // Navigation.toAboutApp,
      ),
      FeatureData(
        iconName: 'feature_log_out',
        title: 'Выйти',
        onTap: _onLogOutTap,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: kIsWeb ? const WebCabinetMenu() : const SizedBox.shrink(),
          automaticallyImplyLeading: false,
          toolbarHeight: kIsWeb ? 60 : 0,
        ),
        body: FullScreen(
          child: Column(
            children: [
              const SizedBox(height: 64),
              BlocBuilder<FeaturesBloc, FeaturesState>(
                builder: (context, state) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (state.organizationTitle != null)
                        Text(
                          state.organizationTitle!,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.36,
                          ),
                        ),
                      if (state.organizationUnp != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Text(
                            'УНП ${state.organizationUnp}',
                            style: TextStyle(
                              color: AppStyles.mainTextColor.withOpacity(.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.symmetric(vertical: 24),
                itemBuilder: (context, index) => FeatureItem(
                  item: _features[index],
                ),
                separatorBuilder: (context, _) => Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Divider(
                    height: 1,
                    color: AppStyles.mainTextColor.withOpacity(.2),
                    // color: Colors.purple,
                  ),
                ),
                itemCount: _features.length,
              ),
            ],
          ),
        ),
      );

  void _onLogOutTap() {
    var isCredentialsSaveChecked = false;
    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState is SettingsInitial) {
      isCredentialsSaveChecked = settingsState.isChangePinAvailable;
    }

    Multiplatform.showDecisionMessage(
      context: context,
      message: isCredentialsSaveChecked
          ? 'Ваши авторизационные данные будут удалены с устройства'
          : null,
      action: () {
        context.read<AuthMdomBloc>().add(AuthMdomLogOut());
        AutoRouter.of(context)
            .push(!kIsWeb ? const SplashRoute() : const AuthRoute());
      },
      dialogTitle: 'Уверены, что хотите выйти?',
      buttonTitle: 'Выйти',
      cancelButtonTitle: 'Остаться',
    );
  }
}
