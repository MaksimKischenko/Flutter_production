import 'package:bpc/models/models.dart';
import 'package:bpc/screens/polls_list_filters/main_widgets/polls_list_filters_web_screen_body.dart';
import 'package:bpc/screens/screens.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PollsListFiltersWebScreen extends StatefulWidget {
  // static const pageRoute = '/polls/filters';
  static const pageRoute = '${PollsListScreen.pageRoute}/:filters';
  final PollsListFiltersData initialFilters;

  const PollsListFiltersWebScreen({Key? key, required this.initialFilters})
      : super(key: key);

  @override
  State<PollsListFiltersWebScreen> createState() =>
      _PollsListFiltersWebScreenState();
}

class _PollsListFiltersWebScreenState extends State<PollsListFiltersWebScreen> {
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
    _scrollController.dispose();
    _endDateRangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
        title: 'Голосования',

        titleActionWidget: TextButton(
          onPressed: isResetAvailable ? _onResetTap : null,
          child: Text(
            'Сбросить',
            // TODO
            // context.t.screens.mdomPollsListFilters.resetButton,
            style: TextStyle(
              color: isResetAvailable
                  ? null
                  : AppStyles.mainTextColor.withOpacity(.5),
            ),
          ),
        ),
        onPressed: _onApplyTap,
        buttonTitle: 'Применить',
        buttonActive: true,
        // extendBody: true,
        // appBar: PollsScreenFiltersAppBar(
        //   isResetAvailable: isResetAvailable,
        //   showTitle: _showTitle,
        //   onResetTap: _onResetTap,
        // ),
        body: PollsFiltersWebScreenBody(
          endDateRangeController: _endDateRangeController,
          filters: filters,
          onEndDateRangeChanged: _onEndDateRangeChanged,
          onStatusChange: _onStatusChange,
          scrollController: _scrollController,
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
      filters = filters.copyWith(stopDateFrom: from, stopDateTo: to);
    });
    _updateEndDateRangeText();
  }

  void _updateEndDateRangeText() {
    _endDateRangeController.text =
        '${filters.stopDateFrom.toStringFormatted()} - ${filters.stopDateTo.toStringFormatted()}';
  }

  void _onApplyTap() {
    if (filters.equalTo(widget.initialFilters)) {
      Navigator.pop(context);
    } else {
      Navigator.of(context).pop<PollsListFiltersData>(filters);
    }
  }
}
