import 'package:flutter/cupertino.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class AccessStatusTableItem extends StatelessWidget {
  final bool value;
  final bool isAboutBlocking;
  Color get _statusColor => 
  isAboutBlocking? 
    
  (value ? CupertinoColors.systemRed : CupertinoColors.systemGreen):
  (value ? CupertinoColors.systemGreen : CupertinoColors.systemRed);

  const AccessStatusTableItem({
    Key? key,
    required this.value,
    this.isAboutBlocking = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _statusColor,
          ),
        ), 
        const SizedBox(width: 4),    
        Flexible(
          child: Text(
            isAboutBlocking? 
            (value ? 'Заблокирован': 'Разблокирован'):
            (value ? 'Доступ разрешен': 'Доступ закрыт'),
            style: AppStyles.tableDataTextStyle
            // overflow: TextOverflow.ellipsis,
          ),
        ),                   
      ],
    );
}


