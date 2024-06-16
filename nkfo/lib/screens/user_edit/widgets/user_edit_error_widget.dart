import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/styles.dart';

class UserEditErrorWidget extends StatelessWidget {
  const UserEditErrorWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.maxFinite),
          const Text('Невозможно отредактировать пользователя'),
          const SizedBox(height: 8),
          CupertinoButton(
            onPressed: () =>
                context.read<UserUpdateBloc>().add(UserUpdateInit()),
            child: const Text(
              'Попробовать снова',
              style: TextStyle(color: AppStyles.mainColor),
            ),
          )
        ],
      );
}
