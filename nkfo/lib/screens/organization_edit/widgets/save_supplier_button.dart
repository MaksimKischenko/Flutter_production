import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class SaveSupplierButton extends StatelessWidget {
  final Function() onTap;
  final bool isAvaible;

  const SaveSupplierButton({
    required this.onTap,
    required this.isAvaible,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<SupplierUpdateBloc, SupplierUpdateState>(
    builder: (context, state) {
      if (state is SupplierUpdateLoading) {
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
          onPressed: isAvaible? onTap : null,
          color: AppStyles.mainColor,
          disabledColor: AppStyles.mainTextColor.withOpacity(0.5),
          child: Text(
            'Сохранить',
            style: AppStyles.buttonsWhiteTextStyle
          )
        );
      }
    }
  );
}