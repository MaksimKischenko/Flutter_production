import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/navigation.dart';

import 'widgets.dart';

class MainBodyItemsGrid extends StatelessWidget {
  final ServicesLoaded state;
  final String name;
  final bool isDevice;

  const MainBodyItemsGrid({
    Key? key,
    required this.state,
    required this.isDevice,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isDevice ? 16 : 392),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isDevice ? 30 : 54),
                  Text(
                    name,
                    style: GoogleFonts.openSans(
                      color: const Color(0xff070707),
                      fontSize: isDevice ? 16 : 20,
                      letterSpacing: 0.01,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // const SizedBox(height: 8),
                  // PageSubtitle(state.payRecords.isNotEmpty
                  //     ? 'Выберите услугу из списка ниже'
                  //     : 'Список пуст'),
                  // const SizedBox(height: 16),
                  GridView.builder(
                    itemCount: state.payRecords.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDevice ? 3 : 6,
                      crossAxisSpacing: isDevice ? 16 : 10,
                      mainAxisSpacing: isDevice ? 16 : 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) => ServiceItem(
                      item: state.payRecords[index],
                      onNodeTap: Navigation.toServices,
                      onServiceTap: Navigation.toService,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
