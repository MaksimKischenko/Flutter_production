import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class SupplierNameField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onSearchTap;

  const SupplierNameField({
    required this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.onSearchTap,
  });

  @override
  State<SupplierNameField> createState() => _SupplierNameFieldState();
}

class _SupplierNameFieldState extends State<SupplierNameField> {
  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        autocorrect: false,
        textInputAction: TextInputAction.done,
        maxLength: 12,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          labelText: '${context.t.mobileScreens.mdomAccountAdd.supplierNameField.title}*',
          counterText: '',
          alignLabelWithHint: true,
          labelStyle: AppStyles.inputLabelOutlineStyle,
          enabledBorder: AppStyles.inputBorderOutline,
          border: AppStyles.inputBorderOutline,
          isDense: true,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // IconButton(
              //   onPressed: onChooseUnnTap,
              //   icon:
              //       const Icon(Icons.library_books, color: AppStyles.mainColor),
              // ),
              IconButton(
                onPressed:widget.controller.text.length < 3? null : widget.onSearchTap,
                icon: Icon(Icons.search_rounded, color: widget.controller.text.length < 3? Colors.grey.shade400: AppStyles.mainColor),
              ),
            ],
          ),
        ),
        validator: (name) {
            if ((name?.length ?? 0) < 3) {
              return t.mobileScreens.mdomAccountAdd.supplierNameField.errors.empty;
            } 
            return null;
        },
        onChanged: (_) => setState(() {}),
        onFieldSubmitted: (name) {
          widget.onFieldSubmitted?.call(name);
        },
      );
}
