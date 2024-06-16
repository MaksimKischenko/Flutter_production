import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ClaimItem extends StatelessWidget {
  final Claim item;
  // final SlidableController slidableController;
  final Function(Claim item) onDismissed;
  final Function(Claim item) onClaimPaymentsTap;
  final Function(int id) onDeleteTap;
  final Function(Claim item) onInfoClick;


  const ClaimItem({
    required this.item,
    // required this.slidableController,
    required this.onDismissed,
    required this.onClaimPaymentsTap,
    required this.onDeleteTap,
    required this.onInfoClick
  });

  bool get isPaid => item.paymentSum > 0.0;

  @override
  Widget build(BuildContext context) {
    final invoiceDate = DateFormat(item.invoiceDate.length > 10 ? 'dd.MM.yyyy HH:mm:ss' : 'dd.MM.yyyy').parse(item.invoiceDate);
    final dueDate = DateFormat(item.dueDate.length > 10 ? 'dd.MM.yyyy HH:mm:ss' : 'dd.MM.yyyy').parse(item.dueDate);
    return Slidable(
      key: Key(item.id.toString()),
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () => onDismissed(item)),
        dragDismissible: false,
        children: [
          if (isPaid)
          SlidableAction(
            label: 'Платежи',
            backgroundColor: const Color(0xff56C58A),
            icon: Icons.attach_money,
            foregroundColor: Colors.white,
            onPressed: (context) => onClaimPaymentsTap(item),
          ),
          if (!isPaid)
          SlidableAction(
            label: 'Удалить',
            backgroundColor: const Color(0xffEC5B5B),
            icon: Icons.delete_forever,
            autoClose: false,
            onPressed: (context) {
              Multiplatform.showDecisionMessage(
                context: context,
                message: null,
                action: () => onDeleteTap(item.id),
                dialogTitle: 'Уверены, что хотите удалить требование?',
                buttonTitle: 'Удалить',
                cancelButtonTitle: 'Оставить',
              );
            },
          )
        ],
      ),
      // dismissal: SlidableDismissal(
      //   dragDismissible: false,
      //   child: const SlidableDrawerDismissal(),
      //   onDismissed: (actionType) => onDismissed(item),
      // ),
      // secondaryActionDelegate: SlideActionBuilderDelegate(
      //   actionCount: 1,
      //   builder: (context, index, animation, renderingMode) => isPaid ? IconSlideAction(
      //       caption: 'Платежи',
      //       color: const Color(0xff56C58A).withOpacity(animation?.value ?? 0),
      //       icon: Icons.attach_money,
      //       foregroundColor: Colors.white,
      //       onTap: () => onClaimPaymentsTap(item),
      //     )
      //     : IconSlideAction(
      //       caption: 'Удалить',
      //       color: const Color(0xffEC5B5B).withOpacity(animation?.value ?? 0),
      //       icon: Icons.delete_forever,
      //       closeOnTap: false,
      //       onTap: () {
      //         Multiplatform.showDecisionMessage(
      //           context: context,
      //           message: null,
      //           action: () => onDeleteTap(item.id),
      //           dialogTitle: 'Уверены, что хотите удалить требование?',
      //           buttonTitle: 'Удалить',
      //           cancelButtonTitle: 'Оставить',
      //         );
      //       },
      //     )
      // ),
      child: BlocListener<ClaimsBloc, ClaimsState>(
        listener: (context, state) {
          if (state is ClaimsSuccessDelete) {
            if (state.id == item.id) Slidable.of(context)?.dismiss(ResizeRequest(const Duration(milliseconds: 50), () => onDismissed(item)));
          }
        },
        child: ListTile(
          onTap: () => onInfoClick(item),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          title: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 8, color: item.statusColor())
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.accNum,
                  style: const TextStyle(
                    color: AppStyles.mainColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "${item.fio.surname ?? ""} ${item.fio.firstName ?? ""} ${item.fio.patronic ?? ""}",
                  style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(0.7),
                    fontSize: 12
                  ),
                )
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                final itemWidth = sizingInformation.isNormal || sizingInformation.isSmall// || sizingInformation.isLarge
                    ? sizingInformation.localWidgetSize.width
                    : (sizingInformation.localWidgetSize.width / 12) * 5;
                final dateItemWidth = sizingInformation.isNormal || sizingInformation.isSmall// || sizingInformation.isLarge
                ? sizingInformation.localWidgetSize.width
                : (sizingInformation.localWidgetSize.width / 12) * 7;
                return Wrap(
                  children: [
                    _infoItem(
                      width: itemWidth,
                      title: 'СУММА',
                      subtitle: '${item.sum}',
                    ),
                    _infoItem(
                      width: dateItemWidth,
                      title: 'ВЫСТАВЛЕНО',
                      subtitle: DateFormat('dd.MM.yyyy HH:mm').format(invoiceDate),
                    ),
                    _infoItem(
                      width: itemWidth,
                      title: 'ОПЛАЧЕНО',
                      subtitle: '${item.paymentSum}',
                    ),
                    _infoItem(
                      width: dateItemWidth,
                      title: 'СРОК ОПЛАТЫ',
                      subtitle: DateFormat('dd.MM.yyyy HH:mm').format(dueDate),
                    ),
                  ],
                );
              },
            ),
          )
        ),
      ),
    );
  }

  Widget _infoItem({
    required double width,
    required String title,
    required String subtitle,
  }) => SizedBox(
    width: width,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppStyles.mainTextColor.withOpacity(0.7),
              fontSize: 11
            ),
          ),
          const SizedBox(width: 4),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              subtitle,
              style: const TextStyle(
                color: AppStyles.mainTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    ),
  );
}