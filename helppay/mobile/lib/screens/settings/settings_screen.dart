import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/blocs/blocs.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/screens/settings/widgets/settings_disable_account_button.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  static const pageRoute = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ScrollController _hideBottomNavController;

  final _titleKey = GlobalKey();

  double get titleSize => 40;

  bool _isTitleVisible = false;
  String? notificationMethod;

  bool get _showTitle =>
      _hideBottomNavController.hasClients &&
      _hideBottomNavController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();
    _currentNotificationMethod();
    _hideBottomNavController = ScrollController();
    _hideBottomNavController.addListener(
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
    _hideBottomNavController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<MdomDeleteBloc, MdomDeleteUserState>(
        listener: (context, state) async {
          if (state is MdomDeleteUserError) {
            //RequestUtil.catchNetworkError(context: context, obj: state.error);
            await Multiplatform.showMessage(
              context: context,
              title: t.general.errorModal.title,
              message: t.exceptions.network,
              type: DialogType.error,
            );
          } else if (state is MdomDeleteUserErrorKomplat) {
            final isTokenError = state.errorCode == 403;

            if (!isTokenError) {
              await RequestUtil.catchKomplatError(
                context: context,
                errorCode: state.errorCode,
                errorText: state.errorMessage,
              );
            }
            if (isTokenError) {
              // Future<void>.delayed(const Duration(seconds: 1),
              //     () => Navigation.navigatorKey.currentState?.pop());
              Multiplatform.onExpiredTokenScreenLock(context);
            }
          } else if (state is MdomDeleteUserSuccess) {
            await Multiplatform.showMessage(
              type: DialogType.success,
              context: context,
              title: context
                  .t.mobileScreens.accountInfo.modal.succesProductDelete.title,
              message: context
                  .t.mobileScreens.settings.sections.deleteAccount.success,
            );
            BlocProvider.of<AuthBloc>(context).add(AuthLogOut());
            await Navigation.toAuth();
          }
        },
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            leading: ArrowBack(),
            title: _showTitle
                ? Text(
                    context.t.mobileScreens.settings.title,
                    style: const TextStyle(color: AppStyles.mainColorDark),
                  )
                : null,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: FullScreen(
            bottomSafe: false,
            controller: _hideBottomNavController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                  child: PageTitle(
                    key: _titleKey,
                    text: context.t.mobileScreens.settings.title,
                  ),
                ),
                SectionTitle(
                  context.t.mobileScreens.settings.sections.access.title,
                ),
                AuthWithBiometricsItem(),
                Separator(),
                SettingsItem(
                  onTap: _changePinProceed,
                  text: context
                      .t.mobileScreens.settings.sections.access.changePin,
                ),
                const SizedBox(height: 16),
                SectionTitle(
                  context.t.mobileScreens.settings.sections.account.tilte,
                ),
                Separator(),
                ChangeLanguageItem(
                  onTap: _onChangeLanguageTap,
                ),
                // ChangeNotificationMethodItem(
                //   onTap: _onChangeNotificationMethodTap,
                //   notificationMethodName: notificationMethod ?? '***',
                // ),
                ChangePasswordItem(),
                DeleteUserItem(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );

  // ignore: avoid_void_async
  void _changePinProceed() async {
    final correctPin =
        await SecureStorageManager.read(SecureStorageKeys.pincode);

    Multiplatform.showPinScreen(
      context: context,
      correctPin: correctPin!,
      title: t.modal.pinVerify.title,
      canBiometric: false,
      canCancel: true,
      cancelButtonTitle: t.modal.pinVerify.cancelButton,
      biometricReason: '',
      onSuccess: () {
        Multiplatform.showVerifyPinScreen(
          context: context,
          title: t.modal.pinSetup.title.first,
          confirmTitle: t.modal.pinSetup.title.repeat,
          cancelButtonTitle: t.modal.pinSetup.cancelButton,
          onSuccess: (newPin) async {
            await SecureStorageManager.write(SecureStorageKeys.pincode, newPin);
            unawaited(
              Multiplatform.showMessage(
                context: context,
                title: t.mobileScreens.settings.modal.changePinSuccess.title,
                message:
                    t.mobileScreens.settings.modal.changePinSuccess.message,
                type: DialogType.success,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onChangeLanguageTap() async {
    final newLang =
        await Navigation.toSelectLanguage(context: context, modal: true);
    if (newLang != null) {
      LocaleSettings.setLocale(newLang);
      await PreferencesHelper.write(PrefsKeys.language, newLang.languageTag);
    }
  }

  Future<void> _onChangeNotificationMethodTap() async {
    notificationMethod = await Navigation.toNotificationMethod(
        context: context, currentNotificationMethodName: notificationMethod);
    if (notificationMethod != null) {
      await PreferencesHelper.write(
          PrefsKeys.notificationMethod, notificationMethod);
    } else {
      notificationMethod = await CoreConfig.defaultNotification();
    }
  }

  Future<void> _currentNotificationMethod() async {
    log('STATED');
    notificationMethod = await CoreConfig.defaultNotification();
    setState(() {});
  }
}
