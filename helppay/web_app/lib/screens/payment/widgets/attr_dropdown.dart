import 'package:flutter/material.dart';

class AttrDropdown extends StatelessWidget {
  final List<String> items;
  final String value;
  final Function(String value) onChanged;
  final String hintText;

  const AttrDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
            .toList(),
        onChanged: (newValue) => onChanged(newValue!),
        value: value,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          filled: true,
          fillColor: Colors.grey[200],
          // hintText: hintText,
          helperText: hintText,
        ),
      );
}
