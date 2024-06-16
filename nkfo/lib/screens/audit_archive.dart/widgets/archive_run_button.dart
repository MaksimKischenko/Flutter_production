import 'package:flutter/cupertino.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class ArchiveRunButton extends StatelessWidget {
  final Function() onTap;

  const ArchiveRunButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoButton(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13.5),
    color: AppStyles.mainColor,
    onPressed: onTap,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Архивировать', style: AppStyles.buttonsWhiteTextStyle)
      ],
    ),
  );
}
