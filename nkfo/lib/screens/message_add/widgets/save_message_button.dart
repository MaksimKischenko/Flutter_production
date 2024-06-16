import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class SaveServiceMessageButton extends StatelessWidget {
  final bool isSendingDateKnown;
  final Function() onTap;
  final bool isAvailable;

  const SaveServiceMessageButton({
    required this.onTap,
    required this.isSendingDateKnown,
    this.isAvailable = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<ServerMessageInsertBloc, ServerMessageInsertState>(
    builder: (context, state) {
      if (state is ServerMessageInsertLoading) {
        return CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          onPressed: () {},
          color: AppStyles.mainColor,
          child: const SizedBox(
            width: 77,
            child: Column(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: LoadingIndicator(
                    color: Colors.white,
                  )
                ),
              ],
            ),
          )
        );
      } else {
        return CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          onPressed: isAvailable ? onTap : null,
          disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
          color: AppStyles.mainColor,
          child: Text(
            isSendingDateKnown ? 'Отправить' : 'Сохранить',
            style: GoogleFonts.openSans(
              color: Colors.white
            ),
          )
        );
      }
    }
  );
}