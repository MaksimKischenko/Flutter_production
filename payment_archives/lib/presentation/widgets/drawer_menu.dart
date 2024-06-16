import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/data/data_manager.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/main.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class DrawerMenu extends StatelessWidget {
  final int? selectedIndex;
  final int? selecdedExpandedIndex;
  final DataManager dataManager;

  DrawerMenu({
    Key? key,
    this.selectedIndex,
    this.selecdedExpandedIndex,
  }) : dataManager = getIt<DataManager>() , super(key: key);

  @override

  Widget build(BuildContext context) => Drawer(
    backgroundColor: AppStyles.colorDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: MenuElementType().menuMainElements.length,
            itemBuilder: (context, index) {
              final elementName = MenuElementType().menuMainElements.keys.elementAt(index);
              return ListTile(
                title: DrawerMenuElement(
                  onTap: () async {
                    await AutoRouter.of(context).
                      pushAndPopUntil(MenuElementType.menuElementsToNavigation[elementName] ?? const AuthRoute(), 
                      predicate: (route) => false
                   );
                  },
                  name: elementName,
                  selected: selectedIndex == index,
                  selectedIndex: selectedIndex,
                  selectedExpandedIndex: selecdedExpandedIndex,
                  expansionList:MenuElementType.menuExpandedElementsList[elementName] ?? [],
                ),
              );
            }
          ),
        ),
        BottomDriver(
          dataManager: dataManager,
        )
      ],
    ),
  );
}
  