import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class FiltersTextButton extends StatelessWidget {
  final Function() onAddTap;


  const FiltersTextButton({
    Key? key,
    required this.onAddTap
    }): super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
          onTap: onAddTap,
          behavior: HitTestBehavior.translucent,
          child: const Row(
            children: [
              Icon(Icons.add, size: 18, color: AppStyles.mainColor),
              SizedBox(width: 4),
              Text(
                'Добавить фильтр данных',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppStyles.mainColor,
                ),
              ),
            ],
          )),
    );
}
