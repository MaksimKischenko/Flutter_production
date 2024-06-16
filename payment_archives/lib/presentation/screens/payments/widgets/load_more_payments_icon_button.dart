
import 'package:flutter/material.dart';

import 'package:payment_tracking_module/presentation/styles.dart';

class LoadMorePaymentsIconButton extends StatelessWidget {

  final bool isActive;
  final Function() onTap;

  const LoadMorePaymentsIconButton({
    Key? key,
    this.isActive = true,
    required this.onTap,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) => MaterialButton(
    disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),     
    shape: Border.all(
      color: AppStyles.colorGold
    ),
    onPressed: isActive? onTap : null,
    child: Row(
      children: [
        if (isActive) const Icon(
            Icons.download_for_offline_outlined, size: 16, 
            color: AppStyles.colorGold
        ) else const Icon(
            Icons.download_done_sharp, size: 16, 
            color: AppStyles.whiteColor
        ),
        const SizedBox(width: 4),
        if (isActive) Text(
          'Загрузить еще',
          style: AppStyles.textStyleBlackTextButton.copyWith(
            color: AppStyles.colorGold
          )
        ) else Text(
          'Все загружено',
          style: AppStyles.textStyleBlackTextButton.copyWith(
            color: AppStyles.whiteColor
          )
        ),
      ],
    ),
  );
}


