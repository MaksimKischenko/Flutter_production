import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';

class ContactSourcePickerWidget extends StatefulWidget {
  final Function(String?) onChanged;
  final String? selectedContactOption;
  final MdomResponseParam param;
  final List<MdomLookupItem>? lookUps;
  const ContactSourcePickerWidget(
      {super.key,
      required this.param,
      this.lookUps,
      this.selectedContactOption,
      required this.onChanged});
  @override
  State<ContactSourcePickerWidget> createState() =>
      _ContactSourcePickerWidgetState();
}

class _ContactSourcePickerWidgetState extends State<ContactSourcePickerWidget> {
  final contactSourcePickerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.param.name}:',
              ),
            ),
            Form(
              key: contactSourcePickerKey,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                itemCount: widget.lookUps?.length ?? 0,
                itemBuilder: (context, index) => ListTile(
                  title: Text(widget.lookUps?[index].name ?? ''),
                  leading: Radio<String?>(
                    value: widget.lookUps?[index].evalue,
                    groupValue: widget.selectedContactOption,
                    onChanged: (value) => widget.onChanged(value),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
