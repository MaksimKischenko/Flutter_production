import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/main.dart';
import 'package:helppay_payform_app/screens/check/widgets/check_screen_receipt.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

class CheckScreenReceiptBody extends StatelessWidget {
  final bool isDevice;
  final AttrRecordResponse suplierName;
  final AttrRecordResponse suplierValueName;

  const CheckScreenReceiptBody({
    Key? key,
    required this.isDevice,
    required this.suplierName,
    required this.suplierValueName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<CheckBloc, CheckState>(
        builder: (context, state) {
          Widget body = Container();

          if (state is CheckLoading) {
            body = Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(width: double.maxFinite),
                  LoadingIndicator()
                ],
              ),
            );
          } else if (state is CheckInitial) {
            final name = 'Чек ${state.paymentId}';

            HelpPayApp.setPageTitle(context, name);

            body = CheckScreenReceipt(
              isDevice: isDevice,
              state: state,
              suplierName: suplierName,
              allServiceCode: allServiceCode ?? 0,
              paymentData: suplierValueName,
            );
          } else if (state is CheckError) {
            body = Expanded(
              child: PageError(
                message: RequestUtil.kNetworkError,
                onRepeatTap: () => context.read<CheckBloc>().add(CheckInit()),
              ),
            );
          } else if (state is CheckErrorKomplat) {
            body = Expanded(
              child: PageError(
                message: state.errorText ?? 'Неизвестная ошибка',
                onRepeatTap: () => context.read<CheckBloc>().add(CheckInit()),
              ),
            );
          }
          return body;
        },
      );
}
