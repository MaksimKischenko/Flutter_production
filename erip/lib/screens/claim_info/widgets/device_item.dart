import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/material.dart';

class DeviceItem extends StatelessWidget {
  final Device device;
  final int index;

  const DeviceItem(this.device, this.index);
  
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.maxFinite,
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: AppStyles.mainColor.withOpacity(0.8),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '№${index+1} ${device.nameDevice}',
              style: const TextStyle(
                color: AppStyles.mainColor,
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 16),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Ед.измерения: '),
                    Text(
                      device.itemUnit,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text('Тариф: '),
                    Text(
                      '${device.tariff}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text('Предыдущее показание: '),
                    Text(
                      '${device.evalue}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}