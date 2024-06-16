import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class ServiceItem extends StatelessWidget {
  final MdomService service;
  final Function(MdomService service, BuildContext context) onTap;

  const ServiceItem({
    required this.service,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onTap(service, context),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppStyles.mainColor.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                          text:
                              '${context.t.mobileScreens.mdomAccountInfo.serviceSection.item.count}: ${service.volume ?? '0.00'} ${service.unit ?? ''}',
                          style: TextStyle(
                              color: AppStyles.mainColorDark.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                          children: [
                            TextSpan(
                                text:
                                    '\n${context.t.mobileScreens.mdomAccountInfo.serviceSection.item.rate}: ${service.tariff ?? '0.00'} ${CoreConfig.currency}')
                          ]),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${service.total.toStringAsFixed(2)} ${CoreConfig.currency}',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.25,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xffC7C7CC),
                size: 20,
              )
            ],
          ),
        ),
      );
}
