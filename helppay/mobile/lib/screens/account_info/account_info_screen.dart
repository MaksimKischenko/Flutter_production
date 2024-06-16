import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/utils/utils.dart';
import 'package:helppay/widgets/widgets.dart' as widgets;
import 'package:helppay_core/helppay_core.dart';
import 'package:string_mask/string_mask.dart';

import 'widgets/widgets.dart';

class AccountInfoScreen extends StatefulWidget {
  final MdomLoginResponseProductsCurrent account;

  const AccountInfoScreen({required this.account});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final GlobalKey<NavigatorState> nestedNavigatorKey =
      GlobalKey<NavigatorState>();

  final _info = <String, String>{};

  late MdomResponseParam nameParam;
  late MdomResponseParam numberParam;
  late bool defaultFlag;

  @override
  void initState() {
    super.initState();

    nameParam = widget.account.params.findByAlias(AliasList.productName)!;
    numberParam = widget.account.params.findByAlias(AliasList.number)!;
    defaultFlag =
        (widget.account.params.findByAlias(AliasList.defaultFlag)?.evalue ??
                '0') ==
            '1';
    _info[t.mobileScreens.accountInfo.properties.number] =
        StringMask('UU00 UUUU 0000 0000 0000 0000 0000')
            .apply(numberParam.evalue);
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsSuccessMakeMain) {
            defaultFlag = !defaultFlag;
          }
          if (state is ProductsSuccessDelete) {
            Navigator.of(context).pop();
            Multiplatform.showMessage(
                context: context,
                title: context.t.mobileScreens.accountInfo.modal
                    .succesProductDelete.title,
                message: context.t.mobileScreens.accountInfo.modal
                    .succesProductDelete.message,
                type: DialogType.success);
          }
          if (state is ProductsSuccessRename) {
            // setState(() {});
          }
        },
        child: Navigator(
          key: nestedNavigatorKey,
          onGenerateRoute: (_) => MaterialPageRoute<void>(
            builder: (context) => Builder(
              builder: (context) => CupertinoPageScaffold(
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppStyles.secondaryColor,
                            // borderRadius: BorderRadius.circular(10),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppStyles.secondaryColor.withOpacity(0.2),
                                  blurRadius: 25,
                                  offset: const Offset(0, 4))
                            ]),
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 44),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ArrowBack(),
                            const SizedBox(height: 24),
                            Name(
                              pan: numberParam.evalue ?? '',
                              nameParam: nameParam,
                              onEditPressed: _onEditNamePressed,
                            ),
                            const SizedBox(height: 74)
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 16),
                          separatorBuilder: (context, index) => Divider(
                              color: AppStyles.mainColorDark.withOpacity(0.1)),
                          itemCount: _info.length,
                          itemBuilder: (context, index) =>
                              InfoItem(_info.entries.toList()[index]),
                        ),
                      ),
                      BlocBuilder<ProductsBloc, ProductsState>(
                        builder: (context, state) {
                          Widget body = Container();
                          if (state is ProductsInitial) {
                            body = Column(
                              children: [
                                if (!defaultFlag)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 8),
                                    child: AccountInfoActionButton(
                                      onPressed: _onMakeMainPressed,
                                      title: context.t.mobileScreens.accountInfo
                                          .makeMainButton,
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 0, 28, 0),
                                  child: DeleteButton(
                                    onPressed: _onDeletePressed,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 28, vertical: 8),
                                //   child: AccountInfoActionButton(
                                //     onPressed: () => context
                                //         .read<ProductsBloc>()
                                //         .add(
                                //           GetProductBalance(
                                //             pan: Pan(
                                //               evalue: numberParam.evalue ?? '',
                                //             ),
                                //             typePan: TypePan(evalue: 'ACCOUNT'),
                                //           ),
                                //         ),
                                //     title: 'Get Balance',
                                //   ),
                                // ),
                              ],
                            );
                          }

                          if (state is ProductsLoading) {
                            body = const Padding(
                              padding: EdgeInsets.symmetric(vertical: 44),
                              child: widgets.LoadingIndicator(),
                            );
                          }
                          return body;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _onMakeMainPressed() {
    context.read<ProductsBloc>().add(ProductsMakeMain(product: widget.account));
  }

  void _onDeletePressed() {
    Multiplatform.showDecisionMessage(
        context: context,
        dialogTitle: t.mobileScreens.accountInfo.modal.deleteProduct.title,
        message: !defaultFlag
            ? t.mobileScreens.accountInfo.modal.deleteProduct.message
            : 'Основной счет, используемый для оплаты будет удалён, появится необходимость выбора другого основного счета.',
        cancelButtonTitle:
            t.mobileScreens.accountInfo.modal.deleteProduct.cancelButton,
        buttonTitle:
            t.mobileScreens.accountInfo.modal.deleteProduct.deleteButton,
        action: () {
          context
              .read<ProductsBloc>()
              .add(ProductsDelete(product: widget.account));
        });
  }

  void _onEditNamePressed() {
    nestedNavigatorKey.currentState?.push<void>(MaterialPageRoute(
      builder: (context) => EditName(
        pan: numberParam.evalue ?? '',
        nameParam: nameParam,
      ),
    ));
  }
}
