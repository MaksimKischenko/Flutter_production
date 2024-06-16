import 'package:flutter/material.dart';
import 'package:helppay_web_app/styles.dart';


class AccrualItem extends StatelessWidget {
  final String title;
  final dynamic subtitle;
  final bool hasForwardIcon;

  const AccrualItem({
    required this.title,
    required this.subtitle,
    this.hasForwardIcon = false,
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
              if (hasForwardIcon) const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xffC7C7CC),
                  size: 20,
                ),
              ) else const SizedBox.shrink()
            ],
          ),
        ],
      ),
    );
}


