import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ExportButton extends StatelessWidget {
  final Function() onTap;

  const ExportButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<AuditBloc, AuditState>(
    builder: (context, state) {
      if (state is AuditLoading) {
        return SizedBox(
          width: 140,
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 20),
            onPressed: null,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: AppStyles.mainColor,
            disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 29),
              child: SizedBox(
                width: 24,
                height: 24,
                child: LoadingIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      } else {
        return SizedBox(
          width: 140,
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppStyles.mainColor),
                borderRadius: BorderRadius.circular(6)
            ),
            onPressed: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.arrow_down_doc, color: AppStyles.mainColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Выгрузить', 
                  style: AppStyles.buttonsBlueTextStyle
                )
              ],
            ),
          ),
        );
      }
    }
  );
}