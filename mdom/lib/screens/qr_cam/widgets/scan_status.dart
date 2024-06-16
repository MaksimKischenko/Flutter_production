import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/routing/routes.gr.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanStatus extends StatelessWidget {
  const ScanStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          alignment: Alignment.topCenter,
          child: BlocBuilder<ClaimQrBloc, ClaimQrState>(
            builder: (context, state) {
              Widget body = Container();
              if (state is ClaimQrInitial) {
                body = const Text(
                  'Наведите камеру на QR-код',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  textAlign: TextAlign.center,
                );
              } else if (state is ClaimQrError) {
                String error;
                if (state.error is ClaimQrNotFoundException) {
                  error = (state.error as ClaimQrNotFoundException).cause;
                } else if (state.error is ClaimQrMissingAccNumException) {
                  error = (state.error as ClaimQrMissingAccNumException).cause;
                } else {
                  error = state.error.toString();
                }

                body = Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 24,
                      color: CupertinoColors.systemRed,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        error,
                        style: const TextStyle(
                            color: CupertinoColors.systemRed, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              } else if (state is ClaimQrErrorKomplat) {
                // RequestUtil.onKomplatErrorAction(
                //   context: context,
                //   errorCode: state.errorCode
                // );
                body = Text(
                  'Комплат ошибка ${state.errorCode}',
                  style: const TextStyle(
                    color: CupertinoColors.systemRed,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                );
                if (state.errorCode == 119) {
                  Future.delayed(
                    const Duration(seconds: 2),
                    () => AutoRouter.of(context).push(const AuthRoute()),
                  );
                }
              } else if (state is ClaimQrLoading) {
                body = const SizedBox(
                  width: 20,
                  height: 20,
                  child: LoadingIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (state is ClaimQrSuccessChecked) {
                const iconStatusMapper = <int, Widget>{
                  // Подготовлено
                  1: Icon(Icons.error_outline,
                      color: CupertinoColors.systemRed),
                  // Оплачено
                  2: Icon(Icons.check, color: CupertinoColors.systemGreen),
                  // Частично оплачено
                  3: Icon(Icons.info_outline,
                      color: CupertinoColors.systemYellow),
                  // Просрочено
                  4: Icon(Icons.error_outline, color: CupertinoColors.systemRed)
                };
                const textStatusMapper = <int, Widget>{
                  // Подготовлено
                  1: Text(
                    'Требование подготовлено',
                    style: TextStyle(
                      color: CupertinoColors.systemRed,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Оплачено
                  2: Text(
                    'Требование оплачено',
                    style: TextStyle(
                      color: CupertinoColors.systemGreen,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Частично оплачено
                  3: Text(
                    'Требование оплачено частично',
                    style: TextStyle(
                      color: CupertinoColors.systemYellow,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Просрочено
                  4: Text(
                    'Требование просрочено',
                    style: TextStyle(
                      color: CupertinoColors.systemRed,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                };
                body = Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    iconStatusMapper[state.claim.status] ??
                        const SizedBox.shrink(),
                    const SizedBox(width: 8),
                    Flexible(
                      fit: FlexFit.loose,
                      child: textStatusMapper[state.claim.status] ??
                          const SizedBox.shrink(),
                    ),
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: body,
              );
            },
          ),
        ),
      );
}
