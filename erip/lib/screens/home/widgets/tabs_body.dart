import 'package:bpc_nkfo/data/data.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class TabsBody extends StatelessWidget {
  final TabController tabController;

  final Map<String, dynamic> main;
  final Map<String, dynamic> contacts;
  final List<Service> services;

  const TabsBody({
    required this.tabController,
    required this.main,
    required this.contacts,
    required this.services
  });

  @override
  Widget build(BuildContext context) => TabBarView(
    controller: tabController,
    children: [
      _buildList(main),
      if (contacts.isNotEmpty) _buildList(contacts),
      if (services.isNotEmpty) _buildServicesList(services)
    ],
  );

  Widget _buildList(Map<String, dynamic> list) {
    final length = list.length;
    return length == 0
        ? Container()
        : Scrollbar(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int i) {
              final key = list.keys.elementAt(i);
              return DefaultListItem(
                title: key,
                subtitle: list[key].toString()
              );
            },
            //separatorBuilder: (context, index) => Divider(height: 5.0),
            itemCount: length
          ),
        );
  }

  Widget _buildServicesList(List<Service> list) => Scrollbar(
    child: ListView.builder(
      itemBuilder: (BuildContext context, int i) => ServiceListItem(list[i]),
      //separatorBuilder: (context, index) => Divider(height: 5.0),
      itemCount: list.length
    ),
  );
}