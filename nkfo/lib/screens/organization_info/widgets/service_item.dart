import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class ServiceItem extends StatelessWidget {
  final SupplierAccount item;
  final Function(SupplierAccount service) onEditTap;
  final Function(SupplierAccount service) onDeleteTap;

  const ServiceItem({
    required this.item,
    required this.onEditTap,
    required this.onDeleteTap
  });

  @override
  Widget build(BuildContext context) => ConfigurableExpansionTile(
    animatedWidgetPrecedingHeader: const Icon(
      CupertinoIcons.chevron_right,
    ),
    animatedWidgetTurnTween: Tween<double>(begin: 0, end: 0.25),
    header: _header(),
    // headerExpanded: _header(),
    children: [
      Responsive(
        runSpacing: 16,
        children: [
          InfoItem(
            title: 'Код услуги (ЕРИП)',
            subtitle: item.paymentSystemServiceCode
          ),
          InfoItem(
            title: 'Номер услуги организации',
            subtitle: item.id.toString()
          ),
          InfoItem(
            title: 'Краткое наименование услуги',
            subtitle: item.serviceShortName
          ),
          InfoItem(
            title: 'Статус',
            subtitle: item.statusText
          ),
          InfoItem(
            title: 'Полное наименование',
            subtitle: item.serviceName,
            colL: 12,
          ),
          InfoItem(
            title: 'Дата подключения услуги',
            subtitle: item.dateStart!.toStringFormatted()
          ),
          InfoItem(
            title: 'Дата прекращения доступа',
            subtitle: item.dateEnd!.toStringFormatted()
          ),
          InfoItem(
            title: 'BIC банка',
            subtitle: item.bic
          ),
          InfoItem(
            title: 'Номер счета',
            subtitle: item.account
          ),
          InfoItem(
            title: 'Минимальная сумма платежа',
            // База отвечает 0 или -1 и поэтому убираем это из поля зрения фронта
            subtitle: item.payMin?.toString() == '0'? '' : item.payMin?.toString() ?? ''
          ),
          InfoItem(
            title: 'Максимальная сумма платежа',
            subtitle: item.payMax?.toString() == '-1'? '' : item.payMax?.toString() ?? ''
          ),
          const InfoCategory('Лицевой счет'),
          InfoItem(
            title: 'Наименование',
            subtitle: item.attrName
          ),
          InfoItem(
            title: 'Тип',
            subtitle: item.valueTypeEnum.name
          ),
          InfoItem(
            title: 'Минимальная длина',
            subtitle: item.minLength?.toString() == '0'? '' : item.minLength?.toString() ?? ''
          ),
          InfoItem(
            title: 'Максимальная длина',
            subtitle: item.maxLength?.toString() == '-1'? '' : item.maxLength?.toString() ?? ''
          ),
          if (item.qrCode != null)
          Div(
            colL: 6,
            colM: 12,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: QrImageView(
                data: item.qrCode!,
                version: QrVersions.auto,
                size: 150,
                gapless: false,
              ),
            ),
          ),
          Div(
            colL: 6,
            colM: 12,
            child: Column(
              children: [
                if (item.stornoMode == null) Container() else _additionalInfo(_workWithStornoMode(item.stornoMode)),
                _additionalInfo(item.autogenPan
                  ? 'Номер лицевого счета генерируется'
                  : 'Номер лицевого счета не генерируется'),
                _additionalInfo(item.advanceEnabled
                  ? 'Разрешено изменять сумму требования при оплате'
                  : 'Запрещено изменять сумму требования при оплате'),
                _additionalInfo(item.scenarioId == 2   //item.claimOnly 
                  ? 'Оплата только по требованию'
                  : 'Возможна оплата без требования'
                ),
              ],
            ),
          ),
        ],
      ),
    ]
  );

  String _workWithStornoMode (String? stornoIndificator) {
    if((stornoIndificator ?? '').contains('S')) {
      return 'Сторнирование разрешено до проведения расчетов';
    } else if ((stornoIndificator ?? '').contains('C')) {
      return 'Сторнирование разрешено в текущем дне';
    } else if ((stornoIndificator ?? '').contains('N')) {
      return 'Сторнирование запрещено';
    }
    return '';
  }

  Widget _additionalInfo(String title) => Container(
    margin: const EdgeInsets.only(top: 16),
    color: Colors.blue[100],
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(
            Icons.info_outline,
            color: AppStyles.mainColor,
          ),
        ),
        Flexible(
          child: Text(
            title,
            style: GoogleFonts.openSans(
              fontSize: 16,
            )
          ),
        ),
      ],
    ),
  );

  Widget _header() => Expanded(
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            item.serviceName ?? 'Неизвестно',
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: item.statusColor
          ),
        ),
        const SizedBox(width: 4),
        Text(
          item.statusText,
          style: GoogleFonts.openSans(
            color: AppStyles.mainTextColor
          ),
        ),
        const Spacer(),
        CupertinoButton(
          // tooltip: 'Редактировать',
          onPressed: () => onEditTap(item),
          child: const Icon(Icons.edit, color: AppStyles.mainColor),
        ),
        CupertinoButton(
          // label: Text('Удалить'),
          onPressed: () => onDeleteTap(item),
          child: const Icon(CupertinoIcons.delete, color: CupertinoColors.systemRed),
        ),
      ],
    ),
  );
}