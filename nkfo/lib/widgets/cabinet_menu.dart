import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/utils/web_helper/web_helper.dart';

import 'widgets.dart';

class CabinetMenu extends StatelessWidget {
  final int? selectedIndex;

  const CabinetMenu({
    required this.selectedIndex
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey[300]!
        )
      )
    ),
    child: Row(
      children: [
        const SizedBox(width: 8),
        Image.asset(
          'assets/logo.jpg',
          height: 32,
        ),
        // Image.network(
        //   'https://ik.imagekit.io/hbtrxkiew/logo_22T-60Ilu.jpg?ik-sdk-version=javascript-1.4.3&updatedAt=1665578225489',
        //   height: 32,
        // ),
        const SizedBox(width: 24),
        CabinetMenuItem(
          selected: selectedIndex == 0,
          onTap: Navigation.toOrganizations,
          icon: CupertinoIcons.building_2_fill,
          text: 'Организации',
        ),
        CabinetMenuItem(
          selected: selectedIndex == 1,
          onTap: Navigation.toUsers,
          icon: CupertinoIcons.person_3_fill,
          text: 'Пользователи',
        ),
        CabinetMenuItem(
          selected: selectedIndex == 2,
          onTap: Navigation.toAudit,
          icon: CupertinoIcons.doc_plaintext,
          text: 'Журнал аудита',
        ),
        CabinetMenuItem(
          selected: selectedIndex == 3,
          onTap: Navigation.toMessages,
          icon: CupertinoIcons.envelope,
          text: 'Рассылки',
        ),
        CabinetMenuItem(
          selected: selectedIndex == 4,
          onTap: Navigation.toJobsManager,
          icon: Icons.work,
          text: 'Менеджер заданий',
        ),
        CabinetMenuItem(
          selected: selectedIndex == 5,
          onTap: Navigation.toSettings,
          icon: CupertinoIcons.settings,
          text: 'Настройки',
        ),
        const Spacer(),
        CabinetMenuItem(
          onTap: _onHelpTap,
          icon: Icons.help_outline_rounded,
          text: 'Справка',
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLogOutSuccess) {
              Navigation.toSplash();
            }
          },
          child: CabinetMenuItem(
            onTap: () => context.read<AuthBloc>().add(AuthLogOut()),
            icon: Icons.exit_to_app_rounded,
            text: 'Выйти',
          ),
        ),
      ],
    ),
  );


  Future<void> _onHelpTap() async {
    final file = await rootBundle.load('assets/files/AdminGuide.pdf');

    SavingHelper.saveFile(file.buffer.asUint8List(), 'AdminGuide.pdf');
  }
}