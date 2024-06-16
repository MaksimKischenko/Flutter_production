import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

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
        // focusNode: focusNode,
        decoration: InputDecoration(
          // prefixIcon: Icon(
          //   Icons.money,
          //   color: Colors.black.withOpacity(0.35),
          //   size: 22,
          // ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 25,
          ),
          hintText: context.t.mobileScreens.qrPayment.p2PpaymentSum,
          // counterText: '',

          alignLabelWithHint: true,
          labelStyle: TextStyle(
              fontSize: 16,
              color: AppStyles.mainColorDark.withOpacity(0.6),
              fontWeight: FontWeight.normal),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  // color: AppStyles.mainColorDark.withOpacity(0.3)
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
