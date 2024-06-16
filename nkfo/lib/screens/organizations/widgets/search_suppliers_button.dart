import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class SearchSuppliersButton extends StatelessWidget {
  final Function() onTap;

  const SearchSuppliersButton({
    required this.onTap
  });
  
  @override
  Widget build(BuildContext context) => BlocBuilder<SuppliersBloc, SuppliersState>(
    builder: (context, state) {
      if (state is SuppliersLoading) {
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
            onPressed: onTap,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: AppStyles.mainColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 20
                  // size: 32,
                ),
                const SizedBox(width: 8),
                Text(
                  'Поиск',
                  style: AppStyles.buttonsWhiteTextStyle,
                )
              ],
            ),
          ),
        );
      }
    }
  );
}