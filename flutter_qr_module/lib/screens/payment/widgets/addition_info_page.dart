import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/blocs/payment/payment_bloc.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/screens/payment/widgets/widgets.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:fl_qr_module/utils/qr_erip.dart';
import 'package:fl_qr_module/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class AdditionInfoPage extends StatefulWidget {
  final ScrollController scrollController;
  QrEripData? data;

  AdditionInfoPage({
    Key? key,
    required this.scrollController,
    this.data,
  }) : super(key: key);

  @override
  _AdditionInfoPageState createState() => _AdditionInfoPageState();
}

class _AdditionInfoPageState extends State<AdditionInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleKey = GlobalKey();
  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      (widget.scrollController.hasClients) &&
      widget.scrollController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset('assets/icon/close.svg',
                colorFilter: const ColorFilter.mode(
                    AppStyles.mainColorDark, BlendMode.srcIn)),
          ),
          title: _showTitle
              ? Text(
                  context
                      .t.mobileScreens.payment.fieldsPage.qrPayVerifyData.title,
                  style: const TextStyle(color: AppStyles.mainColorDark),
                )
              : null,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageTitle(
                            key: _titleKey,
                            text: t.mobileScreens.payment.fieldsPage
                                .qrPayVerifyData.title),
                        Form(
                            key: _formKey,
                            child: AttrField(
                              labelText:
                                  '${context.t.mobileScreens.payment.fieldsPage.qrPayVerifyData.accountNumber}*',
                              hintText: context.t.mobileScreens.payment
                                  .fieldsPage.qrPayVerifyData.accountNumber,
                              editable: true,
                              maxLength: 256,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return context.t.mobileScreens.payment
                                      .fieldsPage.paramField.errors.empty;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                widget.data =
                                    widget.data?.copyWith(accNum: value);
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: NextButton(
                    onPressed: _onSaveTap,
                    text:
                        context.t.mobileScreens.payment.fieldsPage.nextButton),
              )
            ],
          ),
        ),
      );

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<PaymentBloc>().add(PaymentGetInfo(widget.data!));
    }
  }
}
