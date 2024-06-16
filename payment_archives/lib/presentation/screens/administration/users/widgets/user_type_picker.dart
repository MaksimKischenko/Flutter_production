import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/administration/users/widgets/widgets.dart';


class UserTypePicker extends StatefulWidget {
  final List<UserTypeRoleById> items;
  final UserTypeRoleById? selected;
  final Function(UserTypeRoleById item) onTap;

  const UserTypePicker({
    Key? key,
    required this.items,
    required this.onTap,
    this.selected,
  }) : super(key: key);

  @override
  State<UserTypePicker> createState() => _UserTypePickerState();
}

class _UserTypePickerState extends State<UserTypePicker> {
  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: widget.items.length,
    separatorBuilder: (context, index) => const SizedBox(width: 4),
    itemBuilder: (context, index) => _limitItem(widget.items[index], index),
  );

  Widget _limitItem(UserTypeRoleById item, int index) {
    final selectedItem = widget.selected == widget.items[index];
    return UserRoleItem(
      selected: selectedItem,
      onTap: () {
        context.read<UsersBloc>().add(UsersInit(typeId: item.id));
        widget.onTap(item);
      }, 
      text: item.name
    );
  }
}
