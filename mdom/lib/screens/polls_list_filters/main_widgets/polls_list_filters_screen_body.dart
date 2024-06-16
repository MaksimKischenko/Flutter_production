import 'package:bpc/models/models.dart';
import 'package:bpc/screens/polls_list_filters/widgets/widgets.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PollsScreenFiltersScreenBody extends StatelessWidget {
  final PollsListFiltersData filters;
  final ScrollController scrollController;
  final dynamic Function(PollStatus) onStatusChange;
  final TextEditingController endDateRangeController;
  final dynamic Function(DateTime, DateTime) onEndDateRangeChanged;
  final VoidCallback onApplyTap;
  const PollsScreenFiltersScreenBody({
    super.key,
    required this.filters,
    required this.scrollController,
    required this.onStatusChange,
    required this.endDateRangeController,
    required this.onEndDateRangeChanged,
    required this.onApplyTap,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 32),
                    child: PageTitle(
                      text: 'Голосования',
                      // TODO
                      // text: context.t.screens.mdomPollsListFilters.title
                    ),
                  ),
                  StatusPicker(
                    value: filters.status,
                    onChange: onStatusChange,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: EndDateRangePicker(
                      controller: endDateRangeController,
                      from: filters.stopDateFrom,
                      to: filters.stopDateTo,
                      onChanged: onEndDateRangeChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SafeArea(
              child: ApplyButton(
                onTap: onApplyTap,
              ),
            ),
          )
        ],
      );
}
