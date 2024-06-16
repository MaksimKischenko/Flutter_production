import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/screens/service/widgets/service_screen_image.dart';
import 'package:helppay_payform_app/screens/service/widgets/widgets.dart';
import 'package:helppay_payform_app/utils/loger.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'service_screen_paiment_input_fields');

class ServiceScreenPaymentInputFields extends StatefulWidget {
  final PaymentInputFields state;
  final String title;
  final String suplierName;

  const ServiceScreenPaymentInputFields({
    Key? key,
    required this.state,
    required this.title,
    required this.suplierName,
  }) : super(key: key);
  @override
  _ServiceScreenPaymentInputFieldsState createState() =>
      _ServiceScreenPaymentInputFieldsState();
}

class _ServiceScreenPaymentInputFieldsState
    extends State<ServiceScreenPaymentInputFields> {
  @override
  Widget build(BuildContext context) {
    _log('Widget state - CODE: ${widget.state.payCode}');

    _log('FINISHED ATTRS: ${widget.state.finishedAttrs};');
    _log('PROPERTIES: ${widget.state.properties};');
    _log('SERVICE: ${widget.state.service};\n ');
    _log('REMAINING AMOUNT: ${widget.state.remainingAmount}');

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDevice =
            sizingInformation.isMobile || sizingInformation.isTablet;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDevice ? 16 : 392,
            vertical: isDevice ? 24 : 54,
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width:
                        isDevice ? MediaQuery.of(context).size.width - 32 : 530,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // PageTitle(
                        //   'Заявка на перевод денежных средств',
                        //   isDevice,
                        // ),
                        // SizedBox(height: 14),
                        // PayFormDivider(),
                        SizedBox(
                          height: (widget.state.service.view != 1) ? 13 : 0,
                        ),
                        // widget.state.service.view != 1
                        //     ?
                        PageSubtitle(
                          'Информация о получателе платежа',
                          isDevice,
                        ),
                        // : SizedBox.shrink(),
                        SizedBox(
                          height: widget.state.service.view != 1 ? 11 : 0,
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     widget.state.service.view != 1
                        //         ? Text(
                        //             'Перевод',
                        //             style: GoogleFonts.openSans(
                        //               color: Color(0xff767676),
                        //               fontStyle: FontStyle.normal,
                        //               fontWeight: FontWeight.w400,
                        //               fontSize: 16,
                        //             ),
                        //           )
                        //         : SizedBox.shrink(),
                        //     SizedBox(
                        //       width: widget.state.service.view != 1 ? 32 : 0,
                        //     ),
                        //     Expanded(
                        //       child:
                        Text(
                          widget.suplierName.isEmpty
                              ? widget.title
                              : widget.suplierName,
                          style: GoogleFonts.openSans(
                            color: Color(0xff333333),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        //     ),
                        //   ],
                        // ),
                        //SizedBox(height: 40),
                        //PageSubtitle(title, isDevice),
                        FieldsPage(
                          key: Key(
                            widget.state.service.sessionId ?? '-1',
                          ),
                          payCode: widget.state.payCode,
                          remainingAmount: widget.state.remainingAmount,
                          service: widget.state.service,
                          finishedAttrs: widget.state.finishedAttrs,
                          properties: widget.state.properties,
                          isDevice: isDevice,
                        ),
                      ],
                    ),
                  ),
                  // if (isDevice || sizingInformation.screenSize.width < 1485)
                  //   SizedBox.shrink()
                  // else if (sizingInformation.screenSize.width < 1725)
                  //   Expanded(
                  //       child: ServiceScreenImage(image: 'assets/img/erip.png'))
                  // else
                  //   ServiceScreenImage(image: 'assets/img/erip.png')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
