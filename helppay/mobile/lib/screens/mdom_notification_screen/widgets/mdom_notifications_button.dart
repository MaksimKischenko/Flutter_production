import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/generated/translations.g.dart';

class MdomNotificationsButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool enableButton;
  const MdomNotificationsButton({super.key, required this.onTap, this.enableButton = true});

  @override
  Widget build(BuildContext context) => SizedBox(
        child: MaterialButton(
          onPressed: enableButton? onTap : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),      
          elevation: 0,
          highlightElevation: 0,  
          minWidth: MediaQuery.of(context).size.width - 8,
          color: AppStyles.mainColor,
          disabledColor: const Color(0xff8498BC), 
          padding: const EdgeInsets.symmetric(vertical: 14), 
          child: Text(
            context.t.mobileScreens.mdomNotificationsScreen.readAllButton,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
          ),
        ),
      );
}
