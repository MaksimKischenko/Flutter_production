import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class AddJobPartButton extends StatelessWidget {
  final Function() onTap;

  const AddJobPartButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<JobPartInsertBloc, JobPartInsertState>(
    builder: (context, state) {
      if (state is JobPartInsertLoading) {
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
          onPressed: onTap,
          color: AppStyles.mainColor,
          child: Text(
            'Ок',
            style: AppStyles.buttonsWhiteTextStyle
          )
        );
      }
    }
  );
}