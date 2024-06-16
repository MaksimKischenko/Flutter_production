import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

@RoutePage()
class MdomPollsListFiltersScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/filters');

  static const pageRoute = '/polls/filters';

  final PollsListFiltersData initialFilters;

  const MdomPollsListFiltersScreen({Key? key, required this.initialFilters})
      : super(key: key);

  @override
  State<MdomPollsListFiltersScreen> createState() =>
      _MdomPollsListFiltersScreenState();
}

class _MdomPollsListFiltersScreenState
    extends State<MdomPollsListFiltersScreen> {
  late ScrollController _scrollController;
  late TextEditingController _endDateRangeController;

  late PollsListFiltersData filters;

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  bool get isResetAvailable => !filters.equalTo(PollsListFiltersData.initial());

  @override
  void initState() {
    super.initState();

    _endDateRangeController = TextEditingController();

    filters = widget.initialFilters;

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_isTitleVisible != _showTitle) {
        setState(() {
          _isTitleVisible = !_isTitleVisible;
        });
      }
    });

    _updateEndDateRangeText();
  }

  @override
  void dispose() {
    _endDateRangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          leadingWidth: 81,
          leading: TextButton(
            onPressed: () => AutoRouter.of(context).pop(),
            child: Text(
              context.t.mobileScreens.mdomPollsListFilters.cancelButton,
            ),
          ),
          title: _showTitle
              ? Text(
                  context.t.mobileScreens.mdomPollsListFilters.title,
                  style: const TextStyle(
                    color: AppStyles.mainColorDark,
                  ),
                )
              : null,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            TextButton(
              onPressed: isResetAvailable ? _onResetTap : null,
              child: Text(
                context.t.mobileScreens.mdomPollsListFilters.resetButton,
                style: TextStyle(
                  color: isResetAvailable
                      ? null
                      : AppStyles.mainTextColor.withOpacity(.5),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
                      child: PageTitle(
                        text:
                            context.t.mobileScreens.mdomPollsListFilters.title,
                      ),
                    ),
                    StatusPicker(
                      value: filters.status,
                      onChange: _onStatusChange,
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: EndDateRangePicker(
                        controller: _endDateRangeController,
                        from: filters.stopDateFrom,
                        to: filters.stopDateTo,
                        onChanged: _onEndDateRangeChanged,
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
                  onTap: _onApplyTap,
                ),
              ),
            )
          ],
        ),
      );

  void _onResetTap() {
    setState(() {
      filters = PollsListFiltersData.initial();
    });
    _updateEndDateRangeText();
  }

  void _onStatusChange(PollStatus value) {
    setState(() {
      filters = filters.copyWith(status: value);
    });
  }

  void _onEndDateRangeChanged(DateTime from, DateTime to) {
    setState(() {
      filters = filters.copyWith(
          stopDateFrom: from,
          stopDateTo:
              to.add(const Duration(hours: 23, minutes: 59, seconds: 59)));
    });
    _updateEndDateRangeText();
  }

  void _updateEndDateRangeText() {
    _endDateRangeController.text =
        '${filters.stopDateFrom.toStringFormatted()} - ${filters.stopDateTo.toStringFormatted()}';
  }

  void _onApplyTap() {
    if (filters.equalTo(widget.initialFilters)) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pop<PollsListFiltersData>(filters);
    }
  }
}
