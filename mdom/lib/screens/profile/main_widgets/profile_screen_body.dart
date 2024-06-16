import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/screens/profile/widgets/widgets.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProfileScreenBody extends StatelessWidget {
  final TabController? tabController;
  final InfoLoaded state;
  final ScrollController scrollController;
  const ProfileScreenBody({
    super.key,
    required this.tabController,
    required this.state,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) => WebConstrainedBox(
        child: TabBarView(
          controller: tabController,
          children: [
            Scrollbar(
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  final item = state.mainInfoList.entries.toList()[index];
                  return DefaultListItem(
                    title: item.key,
                    subtitle: item.value,
                  );
                },
                //separatorBuilder: (context, index) => Divider(height: 5.0),
                itemCount: state.mainInfoList.length,
              ),
            ),
            if (state.contactsList.isNotEmpty)
              Scrollbar(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final item = state.contactsList[index];
                    return DefaultListItem(
                      title: item.contact,
                      subtitle:
                          '${item.position}${item.position.isNotEmpty ? "; " : ""}${item.phone}',
                    );
                  },
                  //separatorBuilder: (context, index) => Divider(height: 5.0),
                  itemCount: state.contactsList.length,
                ),
              ),
            if (state.servicesList.isNotEmpty)
              Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  controller: scrollController,
                  itemBuilder: (context, index) =>
                      ServiceListItem(state.servicesList[index]),
                  //separatorBuilder: (context, index) => Divider(height: 5.0),
                  itemCount: state.servicesList.length,
                ),
              )
          ],
        ),
      );
}
