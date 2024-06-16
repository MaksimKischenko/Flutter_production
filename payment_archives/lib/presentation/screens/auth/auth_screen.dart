import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/screens/auth/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  static const pageRoute = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/auth.png'),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                colors: [
                  AppStyles.colorGold2,
                  Color.fromRGBO(90, 113, 144, .7)
                ],
                stops: [
                  0.0,
                  1.0
                ]
              )
            ),
          ),            
          const Align(
            alignment: Alignment.center,
            child: AuthModule(),
          )
        ],
      )),
  );
}
