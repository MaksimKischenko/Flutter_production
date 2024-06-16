import 'dart:async';

import 'package:fl_qr_module/blocs/blocs.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:fl_qr_module/utils/loger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sms_autofill/sms_autofill.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'loaded_qr_body_widget');

class LoadedQrBodyWidget extends StatefulWidget {
  final double qrFrameSize;
  final GetQrRequestLoaded state;
  const LoadedQrBodyWidget({
    super.key,
    required this.qrFrameSize,
    required this.state,
  });

  @override
  State<LoadedQrBodyWidget> createState() => _LoadedQrBodyWidgetState();
}

class _LoadedQrBodyWidgetState extends State<LoadedQrBodyWidget> {
  bool showExpired = false;
  late int timeLeft;
  // bool _isGenerateQrButtonVisible = false;
  late Timer periodicTimer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      setState(() {
        timeLeft = timeLeft - 1;
      });
      if (timeLeft == 0) timer.cancel();
    },
  );

  @override
  void initState() {
    super.initState();
    showExpired = widget.state.isExpired;
    timeLeft = widget.state.qrCodeLifetime;
    _requestStatusCheck();
  }

  Future<void> _requestStatusCheck() async {
    periodicTimer;
  }

  @override
  void dispose() {
    super.dispose();
    periodicTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: widget.state.qrCodeLifetime), () {
      if (mounted) {
        setState(() {
          showExpired = true;
        });
      }
    });
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 8),
        Stack(
          children: [
            Positioned(
              child: SizedBox(
                width: widget.qrFrameSize,
                height: widget.qrFrameSize,
                child: QrImageView(
                  data: widget.state.qrCode,
                  version: QrVersions.auto,
                  size: widget.qrFrameSize,
                ),
              ),
            ),
            if (showExpired)
              Positioned(
                top: widget.qrFrameSize / 2.5,
                left: widget.qrFrameSize * .25,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      'Истёк',
                      style: TextStyle(
                        color: AppStyles.mainColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Истечёт через $timeLeft',
          style: const TextStyle(
            color: AppStyles.mainColorDark,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: 24,
            height: 24,
            child: InkWell(
              onTap: () async {
                final signature = await SmsAutoFill().getAppSignature;
                // setState(() {
                //   appSignatureID = signature;
                // });
                _log('app isgnature $signature');
                await Future(() => BlocProvider.of<QrRequestBloc>(context)
                    .add(const GetQrRequestRun()));
                //     .then(
                //   (_) => BlocProvider.of<QrRequestStatusBloc>(context).add(
                //     GetRequestStatusRequestRun(
                //       requestId: widget.state.requestId,
                //       continueStatusCheck: true,
                //     ),
                //   ),
                // );
              },
              child: SvgPicture.asset(
                'assets/images/reload_qr_icon.svg',
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 5.5,
        )
      ],
    );
  }
}
