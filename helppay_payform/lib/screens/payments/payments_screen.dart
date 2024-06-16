import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/utils/web_helper/web_helper.dart';

import 'main_widgets/main_widgets.dart';

class PaymentsScreen extends StatefulWidget {
  static const pageName = 'Платежи';
  static const pageRoute = '/payments';

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  @override
  Widget build(BuildContext context) => BlocListener<ConfirmBloc, ConfirmState>(
        listener: (context, state) {
          if (state is ConfirmError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is ConfirmErrorKomplat) {
            RequestUtil.catchKomplatError(
              context: context,
              request: state.request,
              errorCode: state.errorCode,
              errorText: state.errorText,
            );
          } else if (state is ConfirmSuccess) {
            context.read<PaymentsBloc>().add(const PaymentsInit(0, []));
            Multiplatform.showMessage(
              context: context,
              title: 'Успешно',
              message:
                  'Корзина оплачена. Вы будете перенаправлены обратно на сайт юр.лица',
              type: DialogType.success,
            );

            context.read<AuthBloc>().add(AuthLogOut());

            Future<void>.delayed(
              const Duration(seconds: 3),
              () {
                redirectTo(state.returnUrl ?? '', openType: OpenType.sameTab);
              },
            );
          }
        },
        child: Scaffold(
          body: PaymentScreenBody(),
        ),
      );
}
