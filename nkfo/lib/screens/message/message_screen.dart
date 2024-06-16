import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class MessageScreen extends StatefulWidget {
  static const pageName = 'Просмотр уведомления';

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  int messageId = -1;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ServerMessageBloc, ServerMessageState>(
            buildWhen: (_, next) => next is ServerMessageInitial,
            builder: (context, state) {
              if (state is ServerMessageInitial) {
                return const CommonAppBar(
                  title: 'Просмотр уведомления',
                  actions: [
                    //DeleteMessageButton(onTap: _onDeleteTap)
                  ],
                );
              } else {
                return Container();
              }
            }
          ),
          const Divider(),
          Expanded(
            child: BlocConsumer<ServerMessageBloc, ServerMessageState>(
              listener: (context, state) {
                // if (state is ServerMessageDeleteSuccess) {
                //   Navigator.of(context).pop();
                //   context.read<ServerMessagesBloc>().add(ServerMessagesIncomeDeleteMessage(messageId));
                //   Multiplatform.showMessage(
                //     context: context,
                //     title: 'Успешно',
                //     message: 'Уведомление удалено',
                //     type: DialogType.success
                //   );
                // } else if (state is ServerMessageError) {
                //   RequestUtil.catchNetworkError(context: context, obj: state.error);
                // }
              },
              builder: (context, state) {
                Widget body = Container();
                if (state is ServerMessageInitError) {
                  body = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: double.maxFinite),
                      const Text('Невозможно просмотреть уведомление'),
                      const SizedBox(height: 8),
                      CupertinoButton(
                        onPressed: () => context
                            .read<ServerMessageBloc>()
                            .add(ServerMessageInit()),
                        child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                      )
                    ],
                  );
                } else if (state is ServerMessageLoading) {
                  body = const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: double.maxFinite),
                      LoadingIndicator()
                    ],
                  );
                } else if (state is ServerMessageInitial) {
                  messageId = state.message.id;
                  body = Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: SingleChildScrollView(
                      child: ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          var width = 800.0;
                          if (sizingInformation.isMobile || sizingInformation.isTablet) {
                            width = sizingInformation.screenSize.width;
                          }
                          return Center(
                            child: SizedBox(
                              width: width,
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(40),
                                  child: Responsive(
                                    runSpacing: 16,
                                    children: [
                                      const InfoCategory('Уведомление'),
                                      InfoItem(
                                        title: 'Дата создания',
                                        subtitle: state.message.date!.toStringFormatted()
                                      ),
                                      InfoItem(
                                        title: 'Статус',
                                        subtitle: state.message.statusName
                                      ),
                                      InfoItem(
                                        title: 'Заголовок',
                                        subtitle: state.message.heading
                                      ),
                                      InfoItem(
                                        title: 'Текст',
                                        subtitle: state.message.note
                                      ),
                                      const InfoCategory('Параметры'),
                                      InfoItem(
                                        title: 'Дата отправки',
                                        subtitle: state.message.sendingDate!.toStringFormattedGetOperationHistory()
                                      ),
                                      InfoCategory('Адресаты: ${state.message.supplierId?.length} шт.'),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: state.suppliers.map((e) => Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                          child: RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                color: AppStyles.mainTextColor,
                                              ),
                                              text: '${e.unp ?? ''}, ',
                                              children: [
                                                TextSpan(
                                                  text: e.name ?? '',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                  )
                                                )
                                              ]
                                            ),
                                          ),
                                        )).toList(),
                                      )
                                      // ...state.suppliers.map((e) => Text('${e.unp}, ${e.name}')).toList()
                                    ],
                                  ),
                                ),
                              )
                            ),
                          );
                        }
                      )
                    )
                  );
                }
                return body;
              }
            )
          )
        ],
      ),
    )
  );

  // void _onDeleteTap() {
  //   Multiplatform.showDecisionMessage(
  //     context: context,
  //     message: '',
  //     action: () => context.read<ServerMessageBloc>().add(ServerMessageDelete()),
  //     dialogTitle: 'Уверены, что хотите удалить уведомление?',
  //     buttonTitle: 'Удалить',
  //     cancelButtonTitle: 'Нет'
  //   );
  // }
}