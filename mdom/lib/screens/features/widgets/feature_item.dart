import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeatureItem extends StatelessWidget {
  final FeatureData item;
  
  const FeatureItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: item.onTap,
    child: Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icon/${item.iconName}.svg',
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (item.subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    item.subtitle!,
                    style: TextStyle(
                      color: AppStyles.mainTextColor.withOpacity(.5),
                      fontSize: 13
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}