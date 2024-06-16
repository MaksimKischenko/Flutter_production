import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

import 'main_widgets.dart';

class PopularServicesScreenMainBodyContent extends StatelessWidget {
  final bool isDevice;

  const PopularServicesScreenMainBodyContent({Key? key, required this.isDevice})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PopularServicesBloc, PopularServicesState>(
        builder: (context, state) {
          Widget body = Container();

          if (state is PopularServicesLoading) {
            body = Expanded(
              child: Center(
                child: LoadingIndicator(),
              ),
            );
          } else if (state is PopularServicesLoaded) {
            body = MainBodyItemsGrid(
              state: state,
              isDevice: isDevice,
            );
          } else if (state is PopularServicesError) {
            body = Expanded(
              child: PageError(
                message: RequestUtil.kNetworkError,
                onRepeatTap: () => context
                    .read<PopularServicesBloc>()
                    .add(PopularServicesInit()),
              ),
            );
          } else if (state is PopularServicesErrorKomplat) {
            body = Expanded(
              child: PageError(
                message: state.errorText ?? 'Неизвестная ошибка',
                onRepeatTap: () => context
                    .read<PopularServicesBloc>()
                    .add(PopularServicesInit()),
              ),
            );
          }
          return body;
        },
      );
}
