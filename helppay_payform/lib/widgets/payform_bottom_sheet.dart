import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/utils/loger.dart';
import 'package:helppay_payform_app/widgets/payform_bottom_sheet_body.dart';
import 'package:responsive_builder/responsive_builder.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'payform_bottom_sheet');

class PayformBottomSheet extends StatelessWidget {
  final SizingInformation sizingInformation;

  const PayformBottomSheet({
    Key? key,
    required this.sizingInformation,
  }) : super(key: key);
  DeviceSize getDeviceSize(SizingInformation sizingInformation) {
    if (sizingInformation.isMobile ||
        sizingInformation.screenSize.width < 1000) {
      return DeviceSize.small;
    } else if (sizingInformation.isTablet ||
        sizingInformation.screenSize.width < 1400) {
      return DeviceSize.medium;
    } else {
      return DeviceSize.large;
    }
  }

  @override
  Widget build(BuildContext context) {
    _log('Screen size - ${sizingInformation.screenSize.width}');

    DeviceSize deviceSize = getDeviceSize(sizingInformation);

    if (deviceSize == DeviceSize.small) {
      return PayformBottomSheetBody(
        deviceSize: deviceSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Оплата в ЕРИП с помощью зарубежных банковских карт',
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppStyles.mainColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Контакт-центр',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppStyles.mainColor,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.phone, color: AppStyles.mainColor, size: 16),
                Text(
                  '141',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppStyles.mainColor,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return PayformBottomSheetBody(
        deviceSize: deviceSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Оплата в ЕРИП с помощью зарубежных банковских карт',
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppStyles.mainColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Контакт-центр',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppStyles.mainColor,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.phone, color: AppStyles.mainColor, size: 16),
                Text(
                  '141',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppStyles.mainColor,
                  ),
                ),
              ],
            ),

            // Text(
            //   'г. Минск, ул. Толстого, д. 6, оф. 303, info@raschet.by',
            //   style: GoogleFonts.openSans(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //     color: AppStyles.mainColor,
            //   ),
            // ),
            // Text(
            //   'ОАО «НКФО «ЕРИП», ${DateTime.now().year}',
            //   style: GoogleFonts.openSans(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //     color: AppStyles.mainColor,
            //   ),
            // ),
          ],
        ),
      );
    }
    // else {
    //   return PayformBottomSheetBody(
    //     deviceSize: deviceSize,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           'Оплата в ЕРИП с помощью зарубежных банковских карт',
    //           style: GoogleFonts.openSans(
    //             fontSize: 16,
    //             fontWeight: FontWeight.w500,
    //             color: AppStyles.mainColor,
    //           ),
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               'Контакт-центр',
    //               style: GoogleFonts.openSans(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.w500,
    //                 color: AppStyles.mainColor,
    //               ),
    //             ),
    //             const SizedBox(width: 4),
    //             const Icon(Icons.phone, color: AppStyles.mainColor, size: 16),
    //             Text(
    //               '141',
    //               style: GoogleFonts.openSans(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.w500,
    //                 color: AppStyles.mainColor,
    //               ),
    //             ),
    //           ],
    //         ),

    //         // Text(
    //         //   'г. Минск, ул. Толстого, д. 6, оф. 303, info@raschet.by',
    //         //   style: GoogleFonts.openSans(
    //         //     fontSize: 16,
    //         //     fontWeight: FontWeight.w500,
    //         //     color: AppStyles.mainColor,
    //         //   ),
    //         // ),
    //         // Text(
    //         //   'ОАО «НКФО «ЕРИП», ${DateTime.now().year}',
    //         //   style: GoogleFonts.openSans(
    //         //     fontSize: 16,
    //         //     fontWeight: FontWeight.w500,
    //         //     color: AppStyles.mainColor,
    //         //   ),
    //         // ),
    //       ],
    //     ),
    //   );
    // }
  }
}
