import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/navigation.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_widgets/main_widgets.dart';
import 'widgets/widgets.dart';


@RoutePage()
class PollsListScreen extends StatefulWidget {
  static const pageRoute = '/polls';

  const PollsListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PollsListScreen> createState() => _PollsListScreenState();
}

class _PollsListScreenState extends State<PollsListScreen> {
  late TextEditingController _searchController;

  PollsListFiltersData filters = PollsListFiltersData.initial();

  late ScrollController _scrollController;

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      _scrollController.hasClients && _scrollController.offset - titleSize > 0;

  late bool isAvaiable;

  @override
  void initState() {
    super.initState();

    isAvaiable = context.read<FeaturesBloc>().state.isPollAvailable;

    _scrollController = ScrollController();

    _searchController = TextEditingController();

    _scrollController.addListener(() {
      if (_isTitleVisible != _showTitle) {
        setState(() {
          _isTitleVisible = !_isTitleVisible;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: kIsWeb
            ? AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: const WebCabinetMenu(selectedIndex: 3),
                // actions: [
                //   FiltersButton(
                //     onTap: _onFiltersTap,
                //   ),
                //   IconButton(
                //     onPressed: _onAddTap,
                //     icon: const Icon(Icons.add_rounded),
                //   )
                // ],
              )
            : AppBar(
                centerTitle: kIsWeb ? true : Platform.isIOS,
                automaticallyImplyLeading: false,
                title: _showTitle || !isAvaiable
                    ? const Text('Голосования')
                    : null,
                actions: [
                  FiltersButton(
                    onTap: _onFiltersTap,
                  ),
                  IconButton(
                    onPressed: _onAddTap,
                    icon: const Icon(Icons.add_rounded),
                  )
                ],
              ),
        body: !isAvaiable
            ? const FullScreen(
                child: NotAvailable(),
              )
            : PollsListScreenBody(
                searchController: _searchController,
                isAvaiable: isAvaiable,
                filters: filters,
                onRefresh: _onRefresh,
                onFiltersTap: _onFiltersTap,
                scrollController: _scrollController,
              ),
      );

  // ignore: avoid_void_async
  void _onFiltersTap() async {
    final value = await Navigation.toPollsListFilters(
        context: context, initialFilters: filters);
    if (value != null) {
      filters = value;
      _onRefresh();
    }
  }

  void _onAddTap() {
    Navigation.toPollAdd(
      context: context,
    );
  }

  // ignore: avoid_void_async

  void _onRefresh() {
    context.read<PollsListBloc>().add(PollsListInit(filters: filters));
    if (_searchController.text.isNotEmpty) {
      setState(() {
        _searchController.text = '';
      });
    }
  }
}
