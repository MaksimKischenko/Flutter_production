import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/data/data.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/navigation.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:fl_qr_module/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NativeHostSplashScreen extends StatefulWidget {
  static const pageRoute = '/';

  const NativeHostSplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _NativeHostSplashScreenState createState() => _NativeHostSplashScreenState();
}

class _NativeHostSplashScreenState extends State<NativeHostSplashScreen> {
  NativeHostAuthData? data;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => _getDataFromNative());
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<NativeHostAuthBloc, NativeHostAuthState>(
        listener: (context, state) {
          if (state is NativeHostAuthSuccess) {
            _dataReceived(context);
          }
        },
        builder: (context, state) {
          Widget body = Container();
          if (state is NativeHostAuthInitial) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(context.t.mobileScreens.splash.loadingMessage)
              ],
            );
          }
          if (state is NativeHostAuthLoading) {
            body = const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MultiplatformIndicator(),
                SizedBox(height: 16),
                Text('Загрузка канали связи'),
              ],
            );
          }
          // if(state is NativeHostAuthSuccess) {
          //   body =  Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Text('${state.data?.terminalId}'),
          //       const SizedBox(height: 16),
          //       Text('${state.data?.pan}'),
          //       const SizedBox(height: 16),
          //       Text('${state.data?.typePan}'),
          //       const SizedBox(height: 16),
          //       ElevatedButton(onPressed: _authSuccess, child: const Text('NEXT'))
          //     ],
          //   );
          // }
          if (state is NativeHostAuthError) {
            body = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Ошибка канала связи',
                  style: TextStyle(
                      color: AppStyles.mainColorDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: _getDataFromNative,
                  child: Text(
                    context.t.mobileScreens.splash.repeatButton,
                    style: const TextStyle(
                      color: AppStyles.mainColor,
                    ),
                  ),
                )
              ],
            );
          }
          return Scaffold(
            body: FullScreen(
              bottomSafe: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Center(child: SvgPicture.asset('assets/images/logo.svg')),
                  const SizedBox(height: 64),
                  body
                ],
              ),
            ),
          );
        },
      );

  void _dataReceived(BuildContext context) {
    Navigation.toMain();
    Navigation.toQrScan(context: context);
  }

  void _getDataFromNative() {
    context.read<NativeHostAuthBloc>().add(NativeHostAuthRun());
  }
}
