import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:helppay/models/models.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final List<NavItem> items;
  final Function(MenuTab tab) onTap;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static const double iconSize = 24;

  late List<BottomNavigationBarItem> navItems;

  // @override
  // void initState() {
  //   navItems = widget.items.map((e) => _navItem(e.iconName, e.title)).toList();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //to rebuild tabBar when language is changed
    navItems = widget.items.map((e) => _navItem(e.iconName, e.title)).toList();

    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 36),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: AppStyles.mainColor.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 4))
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: navItems
              .mapIndexed((e, index) => Expanded(
                      child: InkWell(
                    onTap: () => widget.onTap(widget.items[index].tab),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 2,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.currentIndex == index)
                            e.activeIcon
                          else
                            e.icon,
                          const SizedBox(height: 4),
                          DefaultTextStyle(
                            style: TextStyle(
                              color: widget.currentIndex == index
                                  ? AppStyles.secondaryColor
                                  : AppStyles.mainColorDark.withOpacity(0.5),
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                            child: Text(
                              e.label ?? '',
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  )))
              .toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(String iconName, String title) =>
      BottomNavigationBarItem(
        // icon: Icon(Icons.home),
        activeIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SvgPicture.asset(
            'assets/icon/$iconName.svg',
            width: iconSize,
            colorFilter: const ColorFilter.mode(AppStyles.secondaryColor, BlendMode.srcIn),
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SvgPicture.asset(
            'assets/icon/$iconName.svg',
            width: iconSize,
            colorFilter: ColorFilter.mode(AppStyles.mainColorDark.withOpacity(0.5), BlendMode.srcIn),
          ),
        ),
        label: title,
      );
}
