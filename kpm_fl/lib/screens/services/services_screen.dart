import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/navigation.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/utils/utils.dart';
import 'package:kpm_fl/widgets/widgets.dart';

import 'widgets/widgets.dart';

class ServicesScreen extends StatefulWidget {
  static const pageRoute = '/services';

  final int code;

  const ServicesScreen({
    Key? key,
    required this.code
  }) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     Future<void>.delayed(const Duration(seconds: 3), () {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          BannerImage(ScreenInfo.of(context).services.logoUrl),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<ServicesBloc, ServicesState>(
              builder: (context, state) {
                Widget body = const SizedBox();
                if (state is ServicesLoading) {
                  body = const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text('Загрузка'),
                      // SizedBox(height: 16),
                      LoadingIndicator()
                    ],
                  );
                } else if (state is ServicesLoaded) {
                  body = GridView.builder(
                    itemCount: state.payRecords.length,
                    itemBuilder: (context, index) => ServiceItem(
                      item: state.payRecords[index],
                      onNodeTap: Navigation.toServices,
                      onServiceTap: Navigation.toService,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 6/3,
                    ),
                  );
                } else if (state is ServicesError) {
                  body = PageError(
                    message: RequestUtil.kNetworkError,
                    showBottomBar: false,
                    onRepeatTap: () => context.read<ServicesBloc>().add(ServicesInit()),
                  );
                } else if (state is ServicesErrorKomplat) {
                  body = PageError(
                    message: state.errorText ?? 'Неизвестная ошибка',
                    showBottomBar: false,
                    onRepeatTap: () => context.read<ServicesBloc>().add(ServicesInit()),
                  );
                }
                return body;
              },
            ),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: GradientButton(
                    onTap: _onBackTap,
                    gradientColors: const [
                      CupertinoColors.systemOrange,
                      CupertinoColors.systemOrange
                    ],
                    child: Text(ScreenInfo.of(context).services.backButtonLabel),
                  )
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GradientButton(
                    onTap: _onHomeTap,
                    gradientColors: const [
                      AppStyles.mainColor,
                      AppStyles.mainColor,
                    ],
                    child: Text(ScreenInfo.of(context).services.homeButtonLabel),
                  )
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  void _onBackTap() {
    Navigator.of(context).pop();
  }

  void _onHomeTap() {
    Navigation.toPopularServices();
  }
}