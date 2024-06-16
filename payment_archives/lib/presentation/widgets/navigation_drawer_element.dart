import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/utils/utils.dart';

// ignore: must_be_immutable
class DrawerMenuElement extends StatefulWidget {

  final String name;
  final int? selectedIndex;
  final int? selectedExpandedIndex;
  final List<String> expansionList;
  final Function() onTap;
  bool selected;


  DrawerMenuElement({
    Key? key,
    required this.name,
    required this.onTap,
    this.selected = false,
    this.selectedIndex,
    this.selectedExpandedIndex,
    this.expansionList = const [],
  }) : super(key: key);

  @override
  State<DrawerMenuElement> createState() => _DrawerMenuElementState();
}

class _DrawerMenuElementState extends State<DrawerMenuElement> {


  @override
  Widget build(BuildContext context) {
    if(widget.expansionList.isEmpty) {
      return emptyElement();
    } else {
      return expansionElement();
    }
  }

 Widget emptyElement() => Ink(
    child: InkWell(
      onTap:  () {
        widget.selected? null : widget.onTap.call();
      }, 
      child: AbsorbPointer( 
        child: ExpansionTile(
          trailing: const Text(''),
          title: Row(
            children: [
              MenuElementType().menuMainElements[widget.name] ?? const Icon(null),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                 widget.name, 
                 style: widget.selected? 
                 AppStyles.menuElementSelected: AppStyles.menuElementUnSelected
                )
              )
            ],
          ),
        ),
      ),
    ),
  );

  Widget expansionElement() => ExpansionTile(
    initiallyExpanded: widget.selected,
    onExpansionChanged: (value) {
      setState(() {
        widget.selected = value;
      });
    },
    expandedCrossAxisAlignment: CrossAxisAlignment.start,
    trailing: Icon(
      Icons.keyboard_arrow_down,
      color: widget.selected? AppStyles.colorSelected : AppStyles.colorUnSelected,
      size: 16,
    ),
    title: Row(
      children: [
        MenuElementType().menuMainElements[widget.name] ?? const Icon(null),
        const SizedBox(width: 10),
        Text(widget.name, style: widget.selected? AppStyles.menuElementSelected: AppStyles.menuElementUnSelected),
      ],
    ),
    children: (widget.expansionList).mapIndexed((e, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4), //only(bottom: 10),
      child: Ink(
        child: InkWell(
           onTap: isSelected(index)? null: () async {
              await AutoRouter.of(context).pushAndPopUntil(MenuElementType.menuElementsToNavigation[widget.expansionList[index]] ?? const AuthRoute(), 
              predicate: (route) => false
           );
          },
          child: Text(
            e, 
            style: isSelected(index)?
              AppStyles.menuElementSelected : AppStyles.menuElementUnSelected
          )
        ),
      ),
    )).toList()
  );

  bool isSelected(int index) => (widget.name == MenuElementType().menuMainElements.keys.elementAt(widget.selectedIndex ?? 0)) && (widget.selectedExpandedIndex == index);
}
