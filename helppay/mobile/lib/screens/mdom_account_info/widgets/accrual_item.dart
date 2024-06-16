import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';

class AccrualItem extends StatelessWidget {
  final String title;
  final dynamic subtitle;
  final bool hasForwardIcon;
  final Map<int, bool>? hasTransparentForwardIcon;
  final int? index;

  const AccrualItem({
    required this.title,
    required this.subtitle,
    this.hasForwardIcon = false,
    this.hasTransparentForwardIcon,
    this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      // horizontal: 16,
      vertical: 4,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppStyles.mainColorDark.withOpacity(0.6),
            fontSize: 16,
          ),
        ),
        Row(
          children: [
            Text(
              subtitle.toString(),
              style: const TextStyle(
                color: AppStyles.mainColorDark,
                fontSize: 18,
              ),
            ),
            if (hasForwardIcon) Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                Icons.arrow_forward_ios,
                color: (hasTransparentForwardIcon?[index] ?? false)  ?  Colors.transparent : const Color(0xffC7C7CC),
                size: 20,
              ),
            ) else const SizedBox.shrink()
          ],
        ),
      ],
    ),
  );
}


