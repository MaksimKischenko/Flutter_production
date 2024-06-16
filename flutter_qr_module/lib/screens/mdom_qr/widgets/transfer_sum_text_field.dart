import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';


class TransferSumTextField extends StatefulWidget {
  final TextEditingController? controller;
  const TransferSumTextField({required this.controller, super.key});

  @override
  State<TransferSumTextField> createState() => _TransferSumTextFieldState();
}

class _TransferSumTextFieldState extends State<TransferSumTextField> {
  @override
  Widget build(BuildContext context) => TextFormField(
        validator: (String? value) {
          if (double.parse(value ?? '') <= 0) {
            return context.t.mobileScreens.qrPayment.p2PAmountError;
          }
          return null;
        },
        controller: widget.controller,
        autocorrect: false,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        maxLength: 6,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 25,
          ),
          hintText: context.t.mobileScreens.qrPayment.p2PpaymentSum,
          alignLabelWithHint: true,
          labelStyle: TextStyle(
              fontSize: 16,
              color: AppStyles.mainColorDark.withOpacity(0.6),
              fontWeight: FontWeight.normal),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent)),
          fillColor: AppStyles.mainColorDark.withOpacity(0.1),
          filled: true,
          isDense: true,
        ),
      );
}
