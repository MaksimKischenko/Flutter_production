import 'package:flutter/material.dart';

import 'package:payment_tracking_module/presentation/routing/dialog_routes.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class SettingsDrawerElement extends StatelessWidget {

  const SettingsDrawerElement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Ink(        
    child: InkWell(
      onTap: () {
        DialogRoutes.toChangePasswordScreen(context: context);
      },      
      child: Row(
        children:  [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppStyles.colorPurple,
              shape: BoxShape.circle
            ),
            child: const Icon(Icons.settings, size: 16, color: AppStyles.colorWhite3),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text('Настройки',
            style: AppStyles.textStyleWhiteNavigationButton
          ))                           
        ],
      ),
    ),
  );
}
