import 'package:bpc/models/models.dart';
import 'package:bpc/screens/polls_list_filters/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PollsFiltersWebScreenBody extends StatelessWidget {
  final PollsListFiltersData filters;
  final ScrollController scrollController;
  final dynamic Function(PollStatus) onStatusChange;
  final TextEditingController endDateRangeController;
  final dynamic Function(DateTime, DateTime) onEndDateRangeChanged;

  const PollsFiltersWebScreenBody({
    super.key,
    required this.filters,
    required this.scrollController,
    required this.onStatusChange,
    required this.endDateRangeController,
    required this.onEndDateRangeChanged,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: ListView(
          children: [
            StatusPicker(
              value: filters.status,
              onChange: onStatusChange,
            ),
            const SizedBox(height: 24),
            EndDateRangePicker(
              controller: endDateRangeController,
              from: filters.stopDateFrom,
              to: filters.stopDateTo,
              onChanged: onEndDateRangeChanged,
            ),
          ],
        ),
      );
}
