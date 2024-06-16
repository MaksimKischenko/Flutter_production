import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/navigation.dart';
import 'package:helppay_web_app/routing/routes.gr.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/utils/utils.dart';
import 'package:helppay_web_app/widgets/widgets.dart';
import 'package:string_mask/string_mask.dart';

import 'widgets/widgets.dart';

@RoutePage()
class AccountInfoScreen extends StatefulWidget {
  static const PageInfo<dynamic> routePage = PageInfo('/accountInfo');

  static const pageRoute = '/accountInfo';
  final MdomLoginResponseProductsCurrent? account;

  const AccountInfoScreen({this.account});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final _info = <String, String>{};

  MdomResponseParam? nameParam;
  MdomResponseParam? numberParam;
  bool? defaultFlag;

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      nameParam = widget.account?.params.findByAlias(AliasList.productName)!;
      numberParam = widget.account?.params.findByAlias(AliasList.number)!;
      defaultFlag =
          (widget.account?.params.findByAlias(AliasList.defaultFlag)?.evalue ??
                  '0') ==
              '1';
      _info[t.mobileScreens.accountInfo.properties.number] =
          StringMask('UU00 UUUU 0000 0000 0000 0000 0000')
              .apply(numberParam?.evalue);
    } else {
      AutoRouter.of(context).replace(const ProductsRoute());
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsSuccessMakeMain) {
            defaultFlag = !(defaultFlag ?? false);
          }
          if (state is ProductsSuccessDelete) {
            AutoRouter.of(context).navigatorKey.currentState?.pop();
            Multiplatform.showMessage(
                context: context,
                title: context.t.mobileScreens.accountInfo.modal
                    .succesProductDelete.title,
                message: context.t.mobileScreens.accountInfo.modal
                    .succesProductDelete.message,
                type: DialogType.success);
          }
          if (state is ProductsSuccessRename) {
            setState(() {});
          }
        },
        child: Scaffold(
            appBar: AppBar(
                title: const CabinetMenu(selectedIndex: 1),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                child: SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () => AutoRouter.of(context)
                                      .popAndPush(const ProductsRoute()),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: AppStyles.mainColor,
                                  )),
                              const SizedBox(width: 8),
                              Expanded(
                                  child:
                                      PageTitle(text: nameParam?.evalue ?? '')),
                              GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: _onEditNamePressed,
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: AppStyles.mainColor,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 40),
                          ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => Divider(
                                color:
                                    AppStyles.mainColorDark.withOpacity(0.1)),
                            itemCount: _info.length,
                            itemBuilder: (context, index) =>
                                InfoItem(_info.entries.toList()[index]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            persistentFooterAlignment: AlignmentDirectional.center,
            persistentFooterButtons: [
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  Widget body = Container();
                  if (state is ProductsInitial) {
                    body = ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!(defaultFlag ?? false))
                            SizedBox(
                              width: 200,
                              child: MakeMainButton(
                                onPressed: _onMakeMainPressed,
                              ),
                            ),
                          SizedBox(
                            width: 200,
                            child: DeleteButton(
                              onPressed: _onDeletePressed,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is ProductsLoading) {
                    body = const Padding(
                      padding: EdgeInsets.symmetric(vertical: 44),
                      child: LoadingIndicator(),
                    );
                  }
                  return body;
                },
              )
            ]),
      );

  void _onMakeMainPressed() {
    context.read<ProductsBloc>().add(ProductsMakeMain(product: widget.account));
  }

  void _onDeletePressed() {
    Multiplatform.showDecisionMessage(
        context: context,
        dialogTitle: t.mobileScreens.accountInfo.modal.deleteProduct.title,
        message: t.mobileScreens.accountInfo.modal.deleteProduct.message,
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
    Navigation.toEditAccountNameScreen(
      context: context,
      pan: numberParam?.evalue ?? '',
      param: nameParam!,
    );
  }
}
