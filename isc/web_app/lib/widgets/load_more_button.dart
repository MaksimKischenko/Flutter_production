import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';


class LoadMoreButton extends StatelessWidget {

  final Function() onTap;
  final String text;
  final bool withAddIcon;

  const LoadMoreButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.withAddIcon = true
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => Ink(
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: withAddIcon? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.download, 
              size: 18, 
              color: AppStyles.mainColor
            ),
            const SizedBox(width: 4),                                        
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppStyles.mainColor,
              ),
            ),
          ],
      ) : Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppStyles.mainColor,
            ),
         ),
      ),
    ),
  );
}