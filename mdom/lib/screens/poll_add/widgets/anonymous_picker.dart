import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class AnonymousPicker extends StatelessWidget {
  final bool value;
  final Function(bool value) onChange;

  const AnonymousPicker({
    Key? key,
    required this.value,
    required this.onChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Вид',
          // TODO
          // context.t.screens.mdomPollsListFilters.statusPicker.title,
          style: TextStyle(
            color: AppStyles.mainTextColor.withOpacity(.5)
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [false, true].map((e) => _item(
            status: e,
            selected: e == value
          )).toList(),
        )
      ],
    ),
  );

  Widget _item({
    required bool status,
    required bool selected,
  }) => InkWell(
    onTap: () => selected ? null : onChange(status),
    borderRadius: BorderRadius.circular(100),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xffF1F3F8)
            : Colors.transparent,
        border: Border.all(
          color: selected
              ? AppStyles.mainColor
              : AppStyles.mainTextColor.withOpacity(.1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(100)
      ),
      child: Text(
        status
            ? 'Закрытое'
            : 'Открытое',
        style: TextStyle(
          color: selected
              ? AppStyles.mainColor
              : AppStyles.mainTextColor,
          // fontWeight: selected ? FontWeight.w500 : null,
        ),
      ),
    ),
  ); 
}