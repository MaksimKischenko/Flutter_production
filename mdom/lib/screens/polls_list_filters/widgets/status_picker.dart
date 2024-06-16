import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatusPicker extends StatelessWidget {
  final PollStatus value;
  final Function(PollStatus value) onChange;

  const StatusPicker({Key? key, required this.value, required this.onChange})
      : super(key: key);

  List<PollStatus> get statuses {
    final list = List<PollStatus>.from(PollStatus.values)
      ..remove(PollStatus.all);
    return list;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: kIsWeb
            ? const EdgeInsets.symmetric(horizontal: 0)
            : const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Статус',
              // TODO
              // context.t.screens.mdomPollsListFilters.statusPicker.title,
              style: TextStyle(color: AppStyles.mainTextColor.withOpacity(.5)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: statuses
                  .map((e) => _item(status: e, selected: e == value))
                  .toList(),
            )
          ],
        ),
      );

  Widget _item({
    required PollStatus status,
    required bool selected,
  }) =>
      InkWell(
        onTap: () => onChange(selected ? PollStatus.all : status),
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? const Color(0xffF1F3F8) : Colors.transparent,
            border: Border.all(
              color: selected
                  ? AppStyles.mainColor
                  : AppStyles.mainTextColor.withOpacity(.1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            status.name,
            style: TextStyle(
              color: selected ? AppStyles.mainColor : AppStyles.mainTextColor,
            ),
          ),
        ),
      );
}
