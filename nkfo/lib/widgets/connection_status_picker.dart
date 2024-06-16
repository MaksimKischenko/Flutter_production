
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class ConnectionStatusPicker extends StatelessWidget {
  final bool value;
  final Function(bool status) onTap;
  
  const ConnectionStatusPicker({
    required this.value,
    required this.onTap,
   Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Статус подключения',
        style: GoogleFonts.openSans(
          fontSize: 16,
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          _listItem(true),
          const SizedBox(width: 8),
          _listItem(false),
        ],
      )
    ],
  );

  Widget _listItem(bool item) {
    final selected = value == item;

    return GestureDetector(
      onTap: selected ? null : () => onTap(item),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: selected
              ? AppStyles.mainColor.withOpacity(0.2)
              : AppStyles.scaffoldColor,
          border: Border.all(
            color: selected
                ? AppStyles.mainColor
                : AppStyles.mainTextColor.withOpacity(0.2),
            width: 1
          ),
          borderRadius: BorderRadius.circular(14)
        ),
        child: Text(item ? 'Подключена' : 'Отключена'),
      ),
    );
  }
}
