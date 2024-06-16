import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/utils/utils.dart';

import 'main_widgets.dart';

class CheckScreenBodyContent extends StatelessWidget {
  final bool isDevice;
  final AttrRecordResponse suplierName;
  final AttrRecordResponse suplierValueName;

  const CheckScreenBodyContent({
    Key? key,
    required this.isDevice,
    required this.suplierName,
    required this.suplierValueName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocConsumer<ConfirmBloc, ConfirmState>(
        listener: (context, state) {
          if (state is ConfirmError) {
            RequestUtil.catchNetworkError(context: context, obj: state.error);
          } else if (state is ConfirmErrorKomplat) {
            Multiplatform.showMessage(
              context: context,
              title: 'Произошла ошибка',
              message: state.errorText ?? '',
              type: DialogType.error,
              redirectAvailable: state.redirectAvailable,
            );
          }
        },
        builder: (context, state) {
          Widget chekBody = Container();
          if (state is ConfirmSuccess) {
            chekBody = CheckScreenReceiptBody(
              isDevice: isDevice,
              suplierName: suplierName,
              suplierValueName: suplierValueName,
            );
          }
          return chekBody;
        },
      );
}
