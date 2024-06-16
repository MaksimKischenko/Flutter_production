// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:payment_tracking_module/data/data_manager.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class BottomDriver extends StatelessWidget {

  final DataManager dataManager;

  const BottomDriver({
    Key? key,
    required this.dataManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      color: AppStyles.colorDark2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            UserNameDrawerElement(
              dataManager: dataManager,
            ),
            const SizedBox(height: 10),
            const SettingsDrawerElement(),
            const SizedBox(height: 10),
            const ExitDrawerElement()
          ],
        ),
      ),
    );
}
