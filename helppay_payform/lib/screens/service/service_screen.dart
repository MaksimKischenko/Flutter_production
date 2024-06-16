import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/screens/service/main_widgets/service_screen_body.dart';
import 'package:helppay_payform_app/utils/utils.dart';

class ServiceScreen extends StatefulWidget {
  static const pageName = 'Загрузка';
  static const pageRoute = '/service';

  final int code;
  final String name;
  final String? suplierName;

  const ServiceScreen({
    required this.code,
    required this.name,
    this.suplierName,
  });

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) => BlocListener<ConfirmBloc, ConfirmState>(
        listener: (context, state) {
          if (state is ConfirmError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is ConfirmErrorKomplat) {
            // RequestUtil.catchKomplatError(
            //   context: context,
            //   request: state.request,
            //   errorCode: state.errorCode,
            //   errorText: state.errorText,
            //   redirectAvailable: state.redirectAvailable
            // );
          } else if (state is ConfirmSuccess) {
            // context.read<PaymentsBloc>().add(const PaymentsInit(0, []));
            // Multiplatform.showMessage(
            //     context: context,
            //     title: 'Успешно',
            //     message:
            //         'Оплачено. Вы будете перенаправлены обратно на сайт юр.лица',
            //     type: DialogType.success);
            // if (state.returnUrl != null) {
            //   Future<void>.delayed(const Duration(seconds: 5), () {
            //     redirectTo(state.returnUrl!, openType: OpenType.sameTab);
            //   });
            // }
          }
        },
        child: ServiceScreenBody(
          code: widget.code,
          name: widget.name,
          suplierName: widget.suplierName ?? '',
        ),
      );
}
