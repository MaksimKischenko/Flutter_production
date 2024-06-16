import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/navigation.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/loger.dart';
import 'package:bpc/utils/multiplatform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'routes');

class WebTitleWidget extends StatefulWidget {
  final Function(ClaimsFilterData) openFilters;

  const WebTitleWidget({
    super.key,
    required this.openFilters,
  });

  @override
  State<WebTitleWidget> createState() => _WebTitleWidgetState();
}

class _WebTitleWidgetState extends State<WebTitleWidget> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Требования',
            style: TextStyle(
              color: AppStyles.mainTextColor,
              fontSize: 24,
              fontWeight: FontWeight.w400,
              letterSpacing: -1.4,
            ),
          ),
          const Spacer(),
          BlocBuilder<ClaimsBloc, ClaimsState>(
            builder: (context, state) {
              if (state is ClaimsInitial) {
                return IconButton(
                  padding: const EdgeInsets.all(4),
                  icon: const Icon(Icons.add_circle_outline),
                  tooltip: 'Новое требование',
                  onPressed: () => checkAvailability(
                    onAvailable: () => Navigation.toNewClaim(
                        context: context,
                        initialService: state.filter.service,
                        filtersData: state.filter),
                    context: context,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          BlocBuilder<ClaimsBloc, ClaimsState>(
            builder: (context, state) {
              if (state is ClaimsInitial) {
                return IconButton(
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Открыть фильтр',
                  onPressed: () => checkAvailability(
                    onAvailable: () => widget.openFilters(state.filter),
                    context: context,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      );

  void checkAvailability(
      {required VoidCallback onAvailable, required BuildContext context}) {
    if (context.read<FeaturesBloc>().state.availableFeatures) {
      onAvailable();
    } else {
      Multiplatform.showMessage<void>(
          context: context,
          title: 'Инфо',
          message: 'Данная функция Вам недоступна',
          type: DialogType.info);
    }
  }
}
