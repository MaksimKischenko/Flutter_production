
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/blocs/profile/profile_bloc.dart';
import 'package:helppay_web_app/navigation.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/profile');

  static const pageRoute = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? notificationMethod;

  @override
  void initState() {
    super.initState();
    _currentNotificationMethod();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const CabinetMenu(selectedIndex: -1),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 720,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PageTitle(
                            text: context.t.mobileScreens.profile.title,
                          ),
                          BlocBuilder<ProfileBloc, ProfileState>(
                            builder: (context, state) {
                              Widget body = Container();
                              if (state is ProfileInitial) {
                                body = GestureDetector(
                                  onTap: () => Navigation.toProfileEditScreen(
                                    context: context,
                                    params: state.userParams,
                                    lookups: state.lookups,
                                  ),
                                  behavior: HitTestBehavior.translucent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      context
                                          .t.mobileScreens.profile.editButton,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppStyles.mainColor,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return body;
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      child: UserTitle(),
                    ),
                    UserParams(),
                    const SizedBox(height: 16),
                    // Separator(),
                    ChangeLanguageItem(
                      onTap: _onChangeLanguageTap,
                    ),
                    // ChangeNotificationMethodItem(
                    //   onTap: _onChangeNotificationMethodTap,
                    //   currentNotificationMethodName: notificationMethod,
                    // ),
                    ChangePasswordItem(),
                    // const SizedBox(height: 16),
                    // SettingsItem(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Future<void> _onChangeLanguageTap() async {
    final newLang = await Navigation.toSelectLanguage(context: context);
    if (newLang != null) {
      LocaleSettings.setLocale(newLang);
      await PreferencesHelper.write(PrefsKeys.language, newLang.languageTag);
    }
  }

  // Future<void> _onChangeNotificationMethodTap() async {
  //   notificationMethod = await Navigation.toSelectNotificationMethod(
  //       context: context,
  //       currentNotificationMethodName: notificationMethod ?? '');
  //   if (notificationMethod != null) {
  //     await PreferencesHelper.write(
  //         PrefsKeys.notificationMethod, notificationMethod);
  //     setState(() {});
  //   } else {
  //     notificationMethod = await CoreConfig.defaultNotification();
  //   }
  // }

  Future<void> _currentNotificationMethod() async {
    notificationMethod = await CoreConfig.defaultNotification();
    setState(() {});
  }
}
