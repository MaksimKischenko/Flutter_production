import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class InfoBlock extends StatefulWidget {
  final Map<String, dynamic> main;
  final Map<String, dynamic> contacts;
  final List<Service> services;

  const InfoBlock({
    required this.main,
    required this.contacts,
    required this.services
  });

  @override
  _InfoBlockState createState() => _InfoBlockState();
}

class _InfoBlockState extends State<InfoBlock> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int tabCount = 1;

  late int contactsCount;
  late int servicesCount;

  @override
  void initState() {
    super.initState();

    contactsCount = widget.contacts.length;
    servicesCount = widget.services.length;

    tabCount = 1;
    if (contactsCount > 0) tabCount += 1;
    if (servicesCount > 0) tabCount += 1;

    _tabController = TabController(length: tabCount, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const BpcDrawer(isInfoSelected: true),
    appBar: AppBar(
      title: const Text('Информация'),
      bottom: tabCount > 1?
          TabBar(
            controller: _tabController,
            tabs: getTabs(contactsCount > 0, servicesCount > 0),
            indicatorColor: AppStyles.mainColor
          )
          : null,
    ),
    body: TabsBody(
      tabController: _tabController,
      main: widget.main,
      contacts: widget.contacts,
      services: widget.services,
    )
  );

  // ignore: avoid_positional_boolean_parameters
  List<Widget> getTabs(bool withContacts, bool withServices) {
    final tabs = [const Tab(text: 'Общая')];
    if (withContacts) tabs.add(const Tab(text: 'Контактные лица'));
    if (withServices) tabs.add(const Tab(text: 'Услуги'));

    return tabs;
  }
}