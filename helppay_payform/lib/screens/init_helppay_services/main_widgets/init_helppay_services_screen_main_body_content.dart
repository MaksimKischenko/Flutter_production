import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'main_widgets.dart';

class InitHelppayServicesBodyContent extends StatelessWidget {
  final SizingInformation sizingInformation;

  final String? routeName;

  const InitHelppayServicesBodyContent({
    Key? key,
    required this.sizingInformation,
    this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDevice = sizingInformation.isMobile ||
        sizingInformation.isTablet ||
        sizingInformation.screenSize.width < 1240;

    return BlocBuilder<InitHelppayServicesBloc, InitHelppayServicesState>(
      builder: (context, state) {
        Widget body = Container();
        if (state is InitHelppayServicesLoading) {
          body = Expanded(
            child: Center(
              child: LoadingIndicator(),
            ),
          );
        } else if (state is InitHelppayServicesLoaded) {
          body = InitHelppayServicesBodyItemsGrid(
            services: state.services,
            isDevice: isDevice,
          );
        } else if (state is InitHelppayNodesLoaded) {
          body = InitHelppayNodesBodyItemsGrid(
            servicesList: state.servicesList,
            nodeRoutesMap: state.routeMap,
            sizingInformation: sizingInformation,
          );
        } else if (state is InitHelppayServicesError) {
          body = Expanded(
            child: PageError(
              message: RequestUtil.kNetworkError,
              onRepeatTap: () => context
                  .read<InitHelppayServicesBloc>()
                  .add(InitHelppayServicesInit()),
            ),
          );
        } else if (state is InitHelppayServicesErrorKomplat) {
          body = Expanded(
            child: PageError(
              message: state.errorText ?? 'Неизвестная ошибка',
              onRepeatTap: () => context
                  .read<InitHelppayServicesBloc>()
                  .add(InitHelppayServicesInit()),
            ),
          );
        }
        return body;
      },
    );
  }
}
