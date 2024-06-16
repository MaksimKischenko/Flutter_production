import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:bpc/utils/multiplatform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceItem extends StatelessWidget {
  final int index;
  final Device device;
  final Function(DeviceActionType action) onActionsTap;

  const DeviceItem({
    required this.index,
    required this.device,
    required this.onActionsTap
  });

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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 16),
              Text(
                '№${index+1} ${device.nameDevice}',
                style: const TextStyle(
                  color: AppStyles.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              if (defaultTargetPlatform == TargetPlatform.iOS)
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: AppStyles.mainColor,
                onPressed: () async {
                  final result = await Multiplatform.showActionSheet<DeviceActionType>(
                    context: context,
                    title: device.nameDevice,
                    actions: [
                      const ModalActionItem(
                        text: 'Редактировать',
                        value: DeviceActionType.edit,
                      ),
                      const ModalActionItem(
                        text: 'Удалить',
                        value: DeviceActionType.delete,
                        isDestructive: true
                      )
                    ]
                  );

                  if (result != null) {
                    onActionsTap(result);
                  }
                }
              ),
              if (defaultTargetPlatform != TargetPlatform.iOS)
              PopupMenuButton<DeviceActionType>(
                icon: const Icon(
                  Icons.more_vert,
                  color: AppStyles.mainColor
                ),
                tooltip: 'Действия',
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: DeviceActionType.edit,
                    child: Text('Редактировать'),
                  ),
                  const PopupMenuItem(
                    value: DeviceActionType.delete,
                    child: Text('Удалить'),
                  ),
                ],
                onSelected: (value) => Future<void>.delayed(const Duration(milliseconds: 300), () => onActionsTap(value)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Ед.измерения: '),
                    Text(
                      '${device.itemUnit}',
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
          ),
        ],
      ),
    ),
  );
}