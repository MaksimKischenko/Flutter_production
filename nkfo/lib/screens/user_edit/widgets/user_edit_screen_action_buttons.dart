import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'edit_screen_form_fields');

class UserEditScreenActionButtons extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController emailController;

  final bool isSaveAvailable;
  final GlobalKey<FormState> formKey;
  final UserUpdateRequest userUpdate;
  final User? user;
  final List<int>? listOFSelectedItemIds;

  const UserEditScreenActionButtons({
    required this.isSaveAvailable,
    required this.formKey,
    required this.userUpdate,
    required this.user,
    required this.listOFSelectedItemIds,
    required this.phoneController,
    required this.emailController,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            UndoButton(
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  Navigation.toOrganizations();
                }
              },
            ),
            const SizedBox(width: 10),
            SaveButton(
              onTap: () => _onSaveTap(context),
              isAvaible: isSaveAvailable,
            )
          ],
        ),
      );

  void _onSaveTap(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      if (user!.blocked == userUpdate.blocked) {
        userUpdate.blocked = null;
      }
      //To avoid error with empty updating without data
      if (userUpdate.name == null) {
        userUpdate
          ..name = user?.name
          ..email = user?.email
          ..phoneNumber = user?.phoneNumber
          ..blocked = user?.blocked;
      }
      context.read<UserUpdateBloc>().add(UserUpdateRun(
          userUpdate
            ..phoneNumber = phoneController.text
            ..email = emailController.text,
          listOFSelectedItemIds));
    }
  }
}
