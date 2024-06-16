import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isc_web_app/blocs/blocs.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/styles.dart';

class ClaimsWebTitleWidget extends StatefulWidget {
  final Function(ClaimsFilterData) openFilters;

  const ClaimsWebTitleWidget({
    super.key,
    required this.openFilters,
  });

  @override
  State<ClaimsWebTitleWidget> createState() => _ClaimsWebTitleWidgetState();
}

class _ClaimsWebTitleWidgetState extends State<ClaimsWebTitleWidget> {
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
      BlocBuilder<ClaimsBloc, ClaimsState>(
        builder: (context, state) {
          if (state is ClaimsInitial) {
            return IconButton(
              splashRadius: 24,
              icon: const Icon(Icons.filter_list),
              tooltip: 'Открыть фильтр',
              onPressed: () => widget.openFilters(state.filter)
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    ],
  );
}
