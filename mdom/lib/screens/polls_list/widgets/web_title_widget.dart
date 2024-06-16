import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/navigation.dart';
import 'package:bpc/screens/polls_list/widgets/widgets.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/multiplatform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebTitleWidget extends StatelessWidget {
  final VoidCallback onFiltersTap;
  final PollStatus status;

  const WebTitleWidget({
    super.key,
    required this.onFiltersTap,
    required this.status,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Голосования',
                style: TextStyle(
                  color: AppStyles.mainTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -1.4,
                ),
              ),
              Spacer(),
              IconButton(
                padding: EdgeInsets.all(4),
                icon: const Icon(Icons.add_rounded),
                tooltip: 'Новое голосование',
                onPressed: () => Navigation.toPollAdd(
                  context: context,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                tooltip: 'Открыть фильтр',
                onPressed: () => onFiltersTap(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: CurrentStatus(value: status),
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
