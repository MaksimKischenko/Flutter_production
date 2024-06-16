import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final List<NavItem> items;
  final Function(MenuTab tab) onTap;

  const BottomNavigation({
    required this.currentIndex,
    required this.items,
    required this.onTap
  });

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static const double iconSize = 24;

  late List<BottomNavigationBarItem> navItems;

  @override
  void initState() {
    navItems = widget.items.map((e) => _navItem(e.iconName, e.title)).toList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: AppStyles.mainColor.withOpacity(0.1),
          blurRadius: 15,
          offset: const Offset(0, 4)
        )
      ]
    ),
    child: SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: navItems.mapIndexed((e, index) => Expanded(
            child: InkWell(
              onTap: () => widget.onTap(widget.items[index].tab),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.currentIndex == index) e.activeIcon else e.icon,
                    const SizedBox(height: 4),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: widget.currentIndex == index
                          ? AppStyles.secondaryColor
                          : AppStyles.mainTextColor.withOpacity(0.5),
                        fontSize: 10,
                        letterSpacing: 0.1
                      ),
                      textAlign: TextAlign.center,
                      child: Text(e.label ?? ''),
                    )
                  ],
                ),
              ),
            )
          )).toList(),
      ),
    ),
  );

  BottomNavigationBarItem _navItem(String iconName, String title) => BottomNavigationBarItem(
    // icon: Icon(Icons.home),
    activeIcon: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SvgPicture.asset(
        'assets/icon/$iconName.svg',
        width: iconSize,
        color: AppStyles.secondaryColor,
      ),
    ),
    icon: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SvgPicture.asset(
        'assets/icon/$iconName.svg',
        width: iconSize,
        color: AppStyles.mainTextColor.withOpacity(0.5),
      ),
    ),
    label: title,
  );
}