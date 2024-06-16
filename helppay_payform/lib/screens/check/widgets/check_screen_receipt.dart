import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/screens/service/widgets/widgets.dart';
import 'package:helppay_payform_app/utils/loger.dart';
import 'package:helppay_payform_app/utils/web_helper/web_helper.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'check_screen_receipt');

class CheckScreenReceipt extends StatefulWidget {
  final bool isDevice;
  final CheckInitial state;
  final AttrRecordResponse? paymentData;
  final AttrRecordResponse? suplierName;
  final int allServiceCode;

  const CheckScreenReceipt({
    Key? key,
    required this.isDevice,
    required this.state,
    required this.paymentData,
    required this.suplierName,
    required this.allServiceCode,
  }) :  super(key: key);

  @override
  State<CheckScreenReceipt> createState() => _CheckScreenReceiptState();
}

class _CheckScreenReceiptState extends State<CheckScreenReceipt> {
  late ScrollController _scrollController;

   @override
   void initState() {
     super.initState();
     _scrollController = ScrollController();

  }

    @override
    void dispose() {
      _scrollController.dispose();
      super.dispose();
    }


  @override
  Widget build(BuildContext context) {
    final dateTime = widget.state.check[1].substring(13).trim();
    final String reciver =
        '${widget.suplierName?.name ?? ''}: ${widget.suplierName?.value ?? ''}';
    final String paymentDataText =
        '${widget.paymentData?.name ?? ''}: ${widget.paymentData?.value ?? ''}';
    //final summ = state.check[10].substring(15).trim();

    final summ = widget.state.check.last.replaceAll(RegExp('[\ \:\А-Яа-я]'), '');
    final serviceCode = widget.state.code - (widget.allServiceCode - 1000000000);

    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        interactive: true,
        controller: _scrollController,    
        child: SingleChildScrollView(
          controller: _scrollController,    
          child: Padding(
            padding: EdgeInsets.only(
              left: widget.isDevice ? 16 : 392,
              right: widget.isDevice ? 16 : 392,
              bottom: widget.isDevice ? 16 : 150,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: widget.isDevice ? 30 : 54),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ваша заявка оформлена',
                      style: GoogleFonts.openSans(
                        color: const Color(0xff070707),
                        fontSize: widget.isDevice ? 16 : 32,
                        letterSpacing: 0.01,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: widget.isDevice
                          ? const EdgeInsets.fromLTRB(0, 22, 0, 70)
                          : EdgeInsets.only(top: 40),
                      child: Container(
                        height: 550,
                        width: 770,
                        padding: widget.isDevice
                            ? EdgeInsets.symmetric(horizontal: 16, vertical: 32)
                            : EdgeInsets.symmetric(
                                horizontal: 60, vertical: 70),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                            color: Color(0xffB7B7B7),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Детали операции',
                              style: GoogleFonts.openSans(
                                color: const Color(0xff070707),
                                fontSize: widget.isDevice ? 16 : 20,
                                letterSpacing: 0.01,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 15),
                            PayFormDivider(),
                            SizedBox(height: 24),
                            _CheckScreenTextfield(
                                text: 'Номер операции: ${widget.state.paymentId}',
                                isDevice: widget.isDevice),
                            SizedBox(height: 8),
                            _CheckScreenTextfield(
                                text: 'Дата операции: $dateTime',
                                isDevice: widget.isDevice),
                            SizedBox(height: 8),
                            _CheckScreenTextfield(
                                text: '$reciver', isDevice: widget.isDevice),
                            SizedBox(height: 8),
                            _CheckScreenTextfield(
                                text: 'Услуга: ${widget.state.name}',
                                isDevice: widget.isDevice),
                            SizedBox(height: 8),
                            _CheckScreenTextfield(
                                text: 'Номер услуги: $serviceCode',
                                isDevice: widget.isDevice),
                            SizedBox(height: 8),
                            _CheckScreenTextfield(
                              text: paymentDataText,
                              isDevice: widget.isDevice,
                            ),
                            SizedBox(height: 8),
                            _CheckScreenTextfield(
                                text: 'Сумма операции: $summ',
                                isDevice: widget.isDevice),
                            SizedBox(height: 40),
                            BlocBuilder<ReturnBackBloc, ReturnBackState>(
                              builder: (context, state) {
                                return CheckButton(
                                    name: 'Понятно!',
                                    onTap: () async {
                                      await Future(
                                        () {
                                          context
                                              .read<AuthBloc>()
                                              .add(AuthLogOut());
                                          Future.delayed(
                                            const Duration(milliseconds: 500),
                                            (() => redirectTo(
                                                state.backUri ?? '',
                                                openType: OpenType.sameTab)),
                                          );
                                          //
                                        },
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckScreenTextfield extends StatelessWidget {
  final bool isDevice;
  final String? text;
  const _CheckScreenTextfield({Key? key, this.text, this.isDevice = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: GoogleFonts.openSans(
        color: const Color(0xff070707),
        fontSize: isDevice ? 16 : 16,
        letterSpacing: 0.01,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
