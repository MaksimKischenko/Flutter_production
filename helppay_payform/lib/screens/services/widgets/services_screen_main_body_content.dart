import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/injection_component.dart';
import 'package:helppay_payform_app/main.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

import 'widgets.dart';

class ServiceScreenMainBodyContent extends StatelessWidget {
  final bool isDevice;

  const ServiceScreenMainBodyContent({Key? key, required this.isDevice})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ServicesBloc, ServicesState>(
        builder: (context, state) {
          Widget body = Container();

          if (state is ServicesLoading) {
            body = Expanded(
              child: Center(
                child: LoadingIndicator(),
              ),
            );
          } else if (state is ServicesLoaded) {
            final name = state.code ==
                    InjectionComponent.getDependency<DynamicConfig>()
                        .allServicesCode
                ? 'Все услуги'
                : state.payRecords.isEmpty
                    ? 'Узел ${state.code}'
                    : state.payRecords.first.groupRecord?.name ??
                        'Узел ${state.code}';
            HelpPayApp.setPageTitle(context, name);

            body = MainBodyItemsGrid(
              state: state,
              name: name,
              isDevice: isDevice,
            );
          } else if (state is ServicesError) {
            body = Expanded(
              child: PageError(
                message: RequestUtil.kNetworkError,
                onRepeatTap: () => context
                    .read<ServicesBloc>()
                    .add(ServicesInit(state.lastCode)),
              ),
            );
          } else if (state is ServicesErrorKomplat) {
            body = Expanded(
              child: PageError(
                message: state.errorText ?? 'Неизвестная ошибка',
                onRepeatTap: () => context
                    .read<ServicesBloc>()
                    .add(ServicesInit(state.lastCode)),
              ),
            );
          }
          return body;
        },
      );
}
