import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:helppay_payform_app/utils/web_helper/web_helper.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PayformTitle extends StatelessWidget {
  final bool isHomeButtonActive;
  final SizingInformation sizingInformation;

  const PayformTitle(
      {Key? key,
      required this.sizingInformation,
      this.isHomeButtonActive = true})
      : super(key: key);

  bool get isDevice =>
      sizingInformation.isMobile ||
      sizingInformation.isTablet ||
      sizingInformation.screenSize.width < 1240;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: isDevice ? 16 : 392, vertical: isDevice ? 12 : 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: kReleaseMode ? null : Navigation.toInitHelppayServices,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgAssets(
                    'icon/erip_transfer.svg',
                    width: isDevice ? 65 : 75,
                    height: isDevice ? 65 : 75,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ЕРИП',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w700,
                            fontSize: isDevice ? 14 : 15,
                            height: isDevice ? 14 / 21 : 15 / 24,
                            color: Color(0xfffEC7D43),
                          ),
                        ),
                        isDevice ? SizedBox(height: 4) : SizedBox(height: 12),
                        Text(
                          'Перевод',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w700,
                            fontSize: isDevice ? 20 : 23,
                            height: isDevice ? 20 / 30 : 23 / 34,
                            color: Color(0xfff1E3E7A),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            if (isHomeButtonActive)
              BlocBuilder<ReturnBackBloc, ReturnBackState>(
                builder: (context, state) {
                  return SizedBox(
                    width: isDevice ? 144 : 189,
                    height: isDevice ? 35 : 48,
                    child: HomeButton(
                      sizingInformation: sizingInformation,
                      onTap: state.backUri != null
                          ? () async => await _logOut(state, context)
                          : null,
                    ),
                  );
                },
              )
          ],
        ),
      );

  Future<void> _logOut(ReturnBackState state, BuildContext context) {
    return Future(
      (() {
        context.read<AuthBloc>().add(AuthLogOut());
        Future.delayed(
          Duration(seconds: 2),
          (() => redirectTo(state.backUri!, openType: OpenType.sameTab)),
        );
        //
      }),
    );
  }
}
