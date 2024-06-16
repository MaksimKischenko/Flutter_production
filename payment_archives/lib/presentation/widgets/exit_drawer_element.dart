import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class ExitDrawerElement extends StatelessWidget {

  const ExitDrawerElement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Ink(
    child: InkWell(
      onTap: () {
        context.read<AuthBloc>().add(AuthLogOut());
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color:  Color(0xffEC6E51),
              shape: BoxShape.circle
            ),
            child: const Icon(Icons.exit_to_app, size: 16, color: AppStyles.colorWhite3),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Text('Выход', style: AppStyles.textStyleWhiteNavigationButton))                           
        ],
      ),
    ),
  );
}
