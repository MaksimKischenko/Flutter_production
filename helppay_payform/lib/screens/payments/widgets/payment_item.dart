import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

class PaymentItem extends StatefulWidget {
  final Payment item;
  final Function(Payment item) onDeleteTap;

  PaymentItem({
    required this.item,
    required this.onDeleteTap
  }) : super(key: Key('Payment ${item.id}'));

  @override
  State<PaymentItem> createState() => _PaymentItemState();
}

class _PaymentItemState extends State<PaymentItem> {
  bool checkExpanded = false;
  bool checkLoaded = false;

  CheckBloc? _bloc;

  @override
  void initState() {
    // _bloc = CheckBloc(
    //   InjectionComponent.getDependency<DataManager>(),
    //   paymentId: widget.item.id,
    //   initialCheckList: []
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocListener<CheckBloc, CheckState>(
    bloc: _bloc,
    listener: (context, state) {
      if (state is CheckInitial) {
        checkLoaded = true;
      }
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppStyles.secondaryTextColor.withOpacity(0.4)
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.description ?? 'Незивестно',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.item.accNum.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppStyles.secondaryTextColor
                          )
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    const Spacer(),
                    Text(
                      '${widget.item.amount} ${AppConfig.mapCurrencyToName[AppConfig.defaultCurrency]}',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    )
                  ],
                ),
                // const SizedBox(height: 12),
                // MouseRegion(
                //   cursor: MouseCursor.defer,
                //   child: GestureDetector(
                //     onTap: () {
                //       if (!_checkLoaded) _bloc!.add(CheckInit());
                //       setState(() {
                //         _checkExpanded = !_checkExpanded;
                //       });
                //     },
                //     behavior: HitTestBehavior.translucent,
                //     child: Row(
                //       children: [
                //         const Icon(
                //           Icons.receipt_long_rounded,
                //           color: AppStyles.mainColor,
                //           size: 20,
                //         ),
                //         const SizedBox(width: 6),
                //         const Text(
                //           'Чек операции',
                //           style: TextStyle(
                //             color: AppStyles.mainColor,
                //           ),
                //         ),
                //         const SizedBox(width: 4),
                //         Icon(
                //           _checkExpanded
                //             ? Icons.keyboard_arrow_down_rounded
                //             : Icons.keyboard_arrow_up_rounded,
                //           color: AppStyles.mainColor,
                //           size: 20,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                if (checkExpanded)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: BlocBuilder<CheckBloc, CheckState>(
                    bloc: _bloc,
                    builder: (context, state) {
                      Widget body = Container();
                      if (state is CheckInitial) {
                        // body = SelectableText(
                        //   state.check,
                        //   style: GoogleFonts.ptMono()
                        // );
                      } else if (state is CheckLoading) {
                        body = const SizedBox(
                          width: 24,
                          height: 24,
                          child: LoadingIndicator(),
                        );
                      } else if (state is CheckError) {
                        body = Column(
                          children: [
                            const Text(
                              RequestUtil.kNetworkError,
                              style: TextStyle(
                                color: AppStyles.secondaryTextColor
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: CupertinoDialogAction(
                                    onPressed: () => _bloc!.add(CheckInit()),
                                    child: const Text(
                                      'Повторить',
                                      style: TextStyle(
                                        color: AppStyles.mainColor
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      } else if (state is CheckErrorKomplat) {
                        body = Column(
                          children: [
                            Text(
                              state.errorText ?? 'Неизвестная ошибка',
                              style: const TextStyle(
                                color: AppStyles.secondaryTextColor
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: CupertinoDialogAction(
                                    onPressed: () => _bloc!.add(CheckInit()),
                                    child: const Text(
                                      'Повторить',
                                      style: TextStyle(
                                        color: AppStyles.mainColor
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }
                      return body;
                    },
                  )
                ),
              ],
            )
          ),
        ),
        IconButton(
          tooltip: 'Удалить',
          onPressed: () => _onDeleteTap(context),
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: CupertinoColors.systemRed,
            size: 28,
          ),
          // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        )
      ],
    ),
  );

  void _onDeleteTap(BuildContext context) {
    Multiplatform.showDecisionMessage(
      context: context,
      message: '',
      action: () => widget.onDeleteTap(widget.item),
      dialogTitle: 'Уверены, что хотите удалить платеж?',
      buttonTitle: 'Удалить',
      cancelButtonTitle: 'Нет'
    );
  }
}