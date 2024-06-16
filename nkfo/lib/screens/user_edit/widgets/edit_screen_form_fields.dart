import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'edit_screen_form_fields');

class EditScreenFormField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final User? user;
  final UserUpdateRequest userUpdate;
  final UserUpdateInitial state;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final List<int> listOfSelectedItemIds;
  final List<int> comparisonList;

  final Function(bool) enableSave;
  final Function(List<int>) changeRole;

  const EditScreenFormField({
    required this.user,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.state,
    required this.userUpdate,
    required this.formKey,
    required this.enableSave,
    required this.listOfSelectedItemIds,
    required this.changeRole,
    required this.comparisonList,
    super.key,
  });

  @override
  State<EditScreenFormField> createState() => _EditScreenFormFieldState();
}

class _EditScreenFormFieldState extends State<EditScreenFormField> {
  final _focusNodes = List.generate(3, (_) => FocusNode());
  final _parentFieldKeys = List.generate(3, (index) => Key('field $index'));
  final _fieldKeys = List.generate(3, (_) => GlobalKey<FormFieldState>());
  late bool isSaveAvailable = false;

  @override
  void initState() {
    super.initState();
    _focusNodes.forEachIndexed((node, index) {
      node.addListener(() {
        if (!_focusNodes[index].hasFocus) {
          _fieldKeys[index].currentState?.validate();
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant EditScreenFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool checkStatus() {
      if (widget.user == null) {
        return isSaveAvailable = false;
      } else {
        return isSaveAvailable = widget.user!.blocked !=
                widget.userUpdate.blocked ||
            (widget.user!.name ?? '') != widget.nameController.text ||
            (widget.user!.email ?? '') != widget.emailController.text ||
            (widget.user!.phoneNumber ?? '') != widget.phoneController.text ||
            !listEquals(widget.listOfSelectedItemIds, widget.comparisonList);
      }
    }

    return Form(
      key: widget.formKey,
      child: Responsive(
        runSpacing: 16,
        children: [
          DivWithPadding(
            child: AttrTextField(
              initialValue: widget.state.user.dateAdd!.toStringFormatted(),
              labelText: 'Дата создания',
              isReadOnly: true,
            ),
          ),
          DivWithPadding(
            child: AttrTextField(
                key: _parentFieldKeys[0],
                fieldKey: _fieldKeys[0],
                focusNode: _focusNodes[0],
                controller: widget.nameController,
                labelText: 'ФИО',
                mandatory: true,
                maxLength: 128,
                onSaved: (value) {
                  if ((widget.user!.name ?? '') != value) {
                    widget.userUpdate.name = value;
                  } else {
                    widget.userUpdate.name = null;
                  }
                },
                onChanged: (_) {
                  setState(() {});
                  checkStatus();
                  widget.enableSave(isSaveAvailable);
                }),
          ),
          DivWithPadding(
            child: AttrTextField(
              initialValue: widget.state.user.login,
              labelText: 'Логин',
              isReadOnly: true,
            ),
          ),
          DivWithPadding(
            child: EmailTextField(
                key: _parentFieldKeys[1],
                fieldKey: _fieldKeys[1],
                focusNode: _focusNodes[1],
                controller: widget.emailController,
                // onSaved: (value) {
                //   if ((widget.user!.email ?? '') != value) {
                //     widget.userUpdate.email = value;
                //   } else {
                //     widget.userUpdate.email = null;
                //   }
                // },
                onChanged: (_) {
                  setState(() {});
                  checkStatus();
                  widget.enableSave(isSaveAvailable);
                }),
          ),
          DivWithPadding(
            child: AttrTextField(
                controller: widget.phoneController,
                labelText: 'Телефон',
                maxLength: 64,
                // onSaved: (value) {                           //In some reason this code stop working so i decide to transfer data to the bloc event from controller without any mediatorы
                //   if ((widget.user!.phoneNumber ?? '') != value) {
                //     _log(
                //         'phone number is different ${widget.user!.phoneNumber != value}');
                //     widget.userUpdate.phoneNumber = widget.phoneController.text;
                //     _log('phone number ${widget.userUpdate.phoneNumber}');
                //   }
                //   // else {
                //   //   _log('phone number ${widget.user!.phoneNumber}');

                //   //   widget.userUpdate.phoneNumber = null;
                //   // }
                // },
                onChanged: (_) {
                  setState(() {});
                  checkStatus();
                  widget.enableSave(isSaveAvailable);
                }),
          ),
          DivWithPadding(
            child: AttrTextField(
              initialValue: widget.state.user.typeDescription,
              labelText: 'Роль',
              isReadOnly: true,
            ),
          ),
          DivWithPadding(
            child: AttrTextField(
              initialValue:
                  '${widget.state.user.supplierUnp ?? ''} ${widget.state.user.supplierName ?? ''}',
              labelText: 'Организация',
              isReadOnly: true,
            ),
          ),
          // if (widget.state.user.typeId == 2) //TODO uncomment for roles development
          //   DivWithPadding(
          //     child: CustomMultiselectDropDown(
          //         listOfRoles: widget.state.roles,
          //         listOfUserRoles: widget.state.userRoles,
          //         listOFSelectedItemIds: widget.listOfSelectedItemIds,
          //         changeRole: (List<int> listOfIds) {
          //           widget.changeRole(listOfIds);
          //           checkStatus();
          //           widget.enableSave(isSaveAvailable);
          //         }),
          //   ),
          DivWithPadding(
            child: AttrLogic(
              value: widget.userUpdate.blocked ?? false,
              onChanged: (value) {
                setState(() => widget.userUpdate.blocked = value);
                checkStatus();
                widget.enableSave(isSaveAvailable);
              },
              text: 'Заблокирован',
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
