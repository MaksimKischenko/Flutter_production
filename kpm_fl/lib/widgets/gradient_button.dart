import 'package:flutter/material.dart';
import 'package:kpm_fl/styles.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onTap;
  final List<Color> gradientColors;
  final double borderRadius;
  final Widget child;
  const GradientButton({
    Key? key,
    this.onTap,
    this.gradientColors = AppStyles.buttonGradientColorsGrey,
    this.borderRadius = 8,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        // stops: const [0.0, 1.0],
        colors: gradientColors,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 32)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        elevation: MaterialStateProperty.all(0),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16
        ),
        textAlign: TextAlign.center,
        child: child,
      ),
      // child: Text(
      //   text.toUpperCase(),
      //   textAlign: TextAlign.center,
      //   style: const TextStyle(
      //     color: Colors.white
      //   ),
      // ),
    ),
  );
}
