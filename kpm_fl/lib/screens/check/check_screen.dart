import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/utils/utils.dart';
import 'package:kpm_fl/widgets/widgets.dart';

class CheckScreen extends StatelessWidget {
  static const pageRoute = '/check';

  final String barcode;

  const CheckScreen({
    Key? key,
    required this.barcode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: double.maxFinite),
          BannerImage(ScreenInfo.of(context).check.logoUrl),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PageTitle(ScreenInfo.of(context).check.title),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PageSubtitle(ScreenInfo.of(context).check.subtitle),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      BlocBuilder<CheckBloc, CheckState>(
                        builder: (context, state) {
                          Widget? body;
                          if (state is CheckShow) {
                            body = SelectableText(
                              state.check,
                              style: const TextStyle(
                                fontSize: 18
                              ),
                              
                            );
                          } else if (state is CheckLoading) {
                            body = const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: double.maxFinite),
                                LoadingIndicator()
                              ],
                            );
                          } else if (state is CheckError) {
                            body = PageError(
                              message: RequestUtil.kNetworkError,
                              onRepeatTap: () => context.read<CheckBloc>().add(CheckInit()),
                              showBottomBar: false,
                            );
                          } else if (state is CheckErrorKomplat) {
                            body = PageError(
                              message: state.errorText ?? 'Неизвестная ошибка',
                              onRepeatTap: () => context.read<CheckBloc>().add(CheckInit()),
                              showBottomBar: false,
                            );
                          }

                          return body ?? const SizedBox();
                        },
                      ),
                      const SizedBox(height: 32),
                      BarcodeWidget(
                        width: 260,
                        barcode: Barcode.code128(),
                        data: barcode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // menu
          const SizedBox(height: 16),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.maxFinite,
                child: GradientButton(
                  onTap: _onHomeTap,
                  gradientColors: const [AppStyles.mainColor, AppStyles.mainColor],
                  child: Text(ScreenInfo.of(context).check.homeButtonLabel),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  void _onHomeTap() {
    Navigation.toPopularServices();
    // Navigator.of(context).pop();
  }
}