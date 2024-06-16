import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class Name extends StatelessWidget {
  final String pan;
  final MdomResponseParam? nameParam;
  final Function() onEditPressed;

  const Name({
    required this.pan,
    required this.nameParam,
    required this.onEditPressed
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ProductsBloc, ProductsState>(
    builder: (context, state) {
      Widget body = Container();
      if (state is ProductsLoading) {
        body = const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 48,
              child: LoadingIndicator()
            )
          ]
        );
      }
      if (state is ProductsInitial) {
        body = Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                nameParam?.evalue ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
            IconButton(
              padding: const EdgeInsets.only(left: 8),
              onPressed: onEditPressed,
              icon: SvgPicture.asset('assets/icon/account_info_edit.svg'),
            )
          ],
        );
      }
      return body;
    },
  );
}