import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';

class CardScreenAppBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  bool shouldFullyObstruct(BuildContext context) {
    // TODO: implement shouldFullyObstruct
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(
          backgroundColor: AppStyles.mainColor,
          // Color(0xFF000000),
          automaticallyImplyLeading: false,
          leadingWidth: 0,
          actions: [
            GestureDetector(
              onTap: Navigation.toMain,
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text('Отменить'),
              )),
            )
          ],
          title: const Text(
            'ОАО БНБ-Банк',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
