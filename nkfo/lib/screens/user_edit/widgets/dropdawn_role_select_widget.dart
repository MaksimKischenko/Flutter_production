import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_cabinet_nkfo/data/data.dart';

class CustomMultiselectDropDown extends StatefulWidget {
  final List<Role>? listOfRoles;
  final List<UserRole>? listOfUserRoles;
  final List<int> listOFSelectedItemIds;
  final Function(List<int>) changeRole;

  const CustomMultiselectDropDown({
    required this.listOfRoles,
    required this.listOfUserRoles,
    required this.listOFSelectedItemIds,
    required this.changeRole,
  });

  @override
  _CustomMultiselectDropDownState createState() =>
      _CustomMultiselectDropDownState();
}

class _CustomMultiselectDropDownState extends State<CustomMultiselectDropDown> {
  String selectedText = '';

  @override
  Widget build(BuildContext context) => ExpansionTile(
        iconColor: Colors.grey,
        title: Text(
          'Выберите роль',
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        children: widget.listOfRoles!
            .map(
              (e) => CheckboxListTile(
                title: Text(e.name),
                value: widget.listOFSelectedItemIds.contains(e.id),
                onChanged: (value) {
                  setState(
                    () {
                      if (!widget.listOFSelectedItemIds.contains(e.id)) {
                        widget.listOFSelectedItemIds.add(e.id);
                      } else {
                        widget.listOFSelectedItemIds.remove(e.id);
                      }
                    },
                  );
                  widget.changeRole(widget.listOFSelectedItemIds);
                },
              ),
            )
            .toList(),
      );
}
