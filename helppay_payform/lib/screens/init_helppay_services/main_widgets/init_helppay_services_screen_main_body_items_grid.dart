import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:helppay_payform_app/screens/init_helppay_services/widgets/widgets.dart';

class InitHelppayServicesBodyItemsGrid extends StatefulWidget {
  final List<Service> services;
  final bool isDevice;

  const InitHelppayServicesBodyItemsGrid({
    Key? key,
    required this.services,
    required this.isDevice,
  }) : super(key: key);

  @override
  State<InitHelppayServicesBodyItemsGrid> createState() =>
      _InitHelppayServicesBodyItemsGridState();
}

class _InitHelppayServicesBodyItemsGridState
    extends State<InitHelppayServicesBodyItemsGrid> {
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) => Expanded(
        child: Scrollbar(
          thumbVisibility: true,
          interactive: true,
          controller: _controller,
          child: SingleChildScrollView(
            controller: _controller,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: widget.isDevice ? 16 : 392),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: widget.isDevice ? 30 : 54),
                  Text(
                    'Выберите банк, на который вы хотите оформить заявку на перевод денежных средств',
                    style: GoogleFonts.openSans(
                      color: const Color(0xff070707),
                      fontSize: widget.isDevice ? 16 : 20,
                      letterSpacing: 0.01,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: GridView.builder(
                      itemCount: widget.services.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.isDevice ? 3 : 6,
                        crossAxisSpacing: widget.isDevice ? 16 : 10,
                        mainAxisSpacing: widget.isDevice ? 16 : 10,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) => InitHelppayServiceItem(
                        item: widget.services[index],
                        onServiceTap: Navigation.toServiceWithSuplierName,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
