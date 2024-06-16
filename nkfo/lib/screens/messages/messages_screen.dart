
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/screens/messages/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

class MessagesScreen extends StatefulWidget {
  static const pageName = 'Рассылки';

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _dateFrom;
  DateTime? _dateTo;
  ServerMessageStatus? _selectedStatus;
  String? emptyTableMessage;
  bool _addIsAvaliable = true;
  bool _editIsAvaliable = true;
  bool _deleteIsAvaliable = true;

  final _titleController = TextEditingController();
  final _textController = TextEditingController();
 
  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
    if (currentAuthState is AuthAuthorized) {
      context.read<ServerMessagesBloc>().add(ServerMessagesInit());
    } else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          context.read<ServerMessagesBloc>().add(ServerMessagesInit());
        }
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _onLoadInfo());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CabinetMenu(
            selectedIndex: 3,
          ),
          Expanded(
            child: BlocConsumer<ServerMessagesBloc, ServerMessagesState>(
              listener: (context, state) {
                if (state is ServerMessagesError) {
                  if(!state.error.toString().contains('Http status error [401]')) {
                    RequestUtil.catchNetworkError(context: context, obj: state.error);
                  }  
                } else if (state is ServerMessagesDeleteSuccess) {
                   Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Уведомление удалено',
                    type: DialogType.success
                  );
                } else if (state is ServerMessageGetNotAllow) {
                  setState(() {
                    emptyTableMessage = state.message;
                    //_addIsAvaliable = false;
                    _deleteIsAvaliable = false;
                    _editIsAvaliable = false;              
                  });
                }
              },
              buildWhen: (prev, next) {
                if (next is ServerMessagesInitLoading) return true;
                if (next is ServerMessagesInitError) return true;
                if (next is ServerMessagesLoaded) return true;
                return false;
              },
              builder: (context, state) {
                Widget body = Container();
                if (state is ServerMessagesInitError) {
                  body = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: double.maxFinite),
                      const Text('Невозможно отобразить рассылку'),
                      const SizedBox(height: 8),
                      CupertinoButton(
                        onPressed: () => context
                          .read<ServerMessagesBloc>()
                          .add(ServerMessagesInit()),
                        child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                      )
                    ],
                  );
                } else if (state is ServerMessagesInitLoading) {
                  body = const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: double.maxFinite),
                      LoadingIndicator()
                    ],
                  );
                } else if (state is ServerMessagesLoaded) {
                  
                  _addIsAvaliable = state.postIsAvaliable;
                  _deleteIsAvaliable = state.deleteIsAvaliable;
                  _editIsAvaliable = state.patchIsAvaliable; 

                  body = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Form(
                          key: _formKey,
                          child: Responsive(
                            runSpacing: 16,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 10,                                
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: WebDatePicker(
                                    labelText: 'с',
                                    onChange: (value) => _dateFrom = value,
                                    needValidation: false,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 10,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: WebDatePicker(
                                    labelText: 'по',
                                    onChange: (value) => _dateTo = value,
                                    needValidation: false,
                                  ),
                                ),
                              ),
                              Div(
                                colL: 2,
                                colM: 6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFieldDropdownSearch<ServerMessageStatus>(
                                    title: 'Статус',
                                    showSearchBox: false,
                                    maxHeight: 150,
                                    items: ServerMessageStatus.values,
                                    itemBuilder: (item) => item.name ?? 'Все',
                                    selected: _selectedStatus,
                                    onTap: (item) => setState(() => _selectedStatus = item),
                                    onSaved: (item) {
                                      if (item?.name == null) {
                                        _selectedStatus = null;
                                      }
                                    },
                                    emptyMessage: 'Все',
                                  ),
                                ),
                              ),
                              Div(
                                colL: 2,
                                colM: 6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: AttrTextField(
                                    controller: _titleController, 
                                    labelText: 'Заголовок',
                                  ),
                                ),
                              ),
                              Div(
                                colL: 2,
                                colM: 6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: AttrTextField(
                                    controller: _textController, 
                                    labelText: 'Текст',
                                  ),
                                ),
                              ),
                              Div(
                                colL: 2,
                                colM: 6,                                
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SearchMessagesButton(onTap: _onSearchTap),
                                    ],
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24,  top: 20),
                        child: ActionButton(
                          onTap: _onAddServerMessageTap
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: BlocBuilder<SettingsBloc, SettingsState>(
                          builder: (context, settingsState) {
                            if (settingsState is SettingsInitial) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: DataTable2(
                                        sortColumnIndex: settingsState.serverMessageItems.indexOf(state.sort),
                                        sortAscending: state.sortAscending,
                                        headingTextStyle: AppStyles.headingTableTextStyle,
                                        columnSpacing: 20,
                                        dataRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                          if(states.contains(MaterialState.hovered)) {
                                            return AppStyles.mainColor.withOpacity(0.2); 
                                          } 
                                          return Colors.transparent;
                                        }),                                        
                                        border: TableBorder.all(color: AppStyles.mainColor, width: 0.5),
                                        headingRowHeight: 80,
                                        smRatio: 0.3,
                                        lmRatio: 1.8,
                                        empty: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:  [
                                            BlocBuilder<ServerMessagesBloc, ServerMessagesState>(
                                              builder: (context, state) {
                                                Widget emtyTableBody = Container();
                                                if(state is ServerMessagesLoading) {
                                                  emtyTableBody = const LoadingIndicator(
                                                    indicatorsSize: 80,
                                                  );
                                                } else if(state is ServerMessageGetNotAllow) {
                                                  emtyTableBody = Column(
                                                    children: [
                                                      const SvgAssets('icon/dialog_error.svg'),
                                                      Text(emptyTableMessage ?? '', style: AppStyles.headerTextStyleLess, textAlign: TextAlign.center),
                                                    ],
                                                  );
                                                }
                                                return emtyTableBody;
                                              },
                                            ),
                                          ],
                                        ),
                                        columns: [
                                          ...settingsState.serverMessageItems.map((e) => DataColumn2(
                                            label: Text(e.name),
                                            size: e.columnSize,
                                            onSort: (_, ascending) => _onSortTap(e, ascending, state.messages.length)
                                          )).toList(),
                                          DataColumn2(
                                            label: Container(),
                                            numeric: true,
                                            size: ColumnSize.S,
                                          ),
                                        ],
                                        rows: state.messages.map((e) => DataRow(
                                          cells: [
                                            if (settingsState.serverMessageItems.contains(ServerMessageSort.title))
                                            DataCell(SelectableText(e.heading ?? 'Неизвестно')),
                                            if (settingsState.serverMessageItems.contains(ServerMessageSort.text))
                                            DataCell(SelectableText(e.note ?? 'Неизвестно')),
                                            if (settingsState.serverMessageItems.contains(ServerMessageSort.creationDate))
                                            DataCell(SelectableText(e.date?.toStringFormattedGetOperationHistory() ?? 'Неизвестно')),
                                            if (settingsState.serverMessageItems.contains(ServerMessageSort.sendingDate))
                                            DataCell(SelectableText(e.sendingDate?.toStringFormattedGetOperationHistory() ?? 'Неизвестно')),
                                            if (settingsState.serverMessageItems.contains(ServerMessageSort.status))
                                            DataCell(Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 12,
                                                  height: 12,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: e.statusColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                Flexible(
                                                  child: Text(
                                                    e.statusName ?? 'Неизвестно',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: AppStyles.mainColorDark
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )),
                                            DataCell(PopupMenuButton<MessageAction>(
                                              onSelected: (value) {
                                                if (value == MessageAction.view) {
                                                  _onViewTap(e);
                                                } else if (value == MessageAction.delete) {
                                                  _onDeleteTap(e.id);                                                
                                                } else if (value == MessageAction.edit) {
                                                  _onEditTap(e);                                              
                                                }
                                              },
                                              itemBuilder: (BuildContext context) => <MessageAction>[
                                                if (e.statusEnum == ServerMessageStatus.sended)
                                                MessageAction.view,
                                                if (e.statusEnum == ServerMessageStatus.pending) 
                                                MessageAction.view,
                                                MessageAction.delete,
                                                if (e.statusEnum == ServerMessageStatus.draft)
                                                MessageAction.edit,
                                              ].mapIndexed((e, i) => PopupMenuItem<MessageAction>(
                                                value: e,
                                                child: Text(
                                                  e.name,
                                                  style: TextStyle(
                                                    color: e.color,
                                                  ),
                                                ),
                                              )).toList(),
                                              child: const Icon(Icons.more_horiz_rounded, size: 16),
                                            )),
                                          ]
                                        )).toList(),
                                      ),
                                    ),
                                    RowCounter(state.messages.length),
                                    BlocBuilder<ServerMessagesBloc, ServerMessagesState>(
                                      builder: (context, state) {
                                        Widget body = Container();
                                        if (state is ServerMessagesLoading) {
                                          // body = Column(
                                          //   mainAxisAlignment: MainAxisAlignment.center,
                                          //   children: const [
                                          //     SizedBox(
                                          //       width: 32,
                                          //       height: 32,
                                          //       child: LoadingIndicator()
                                          //     ),
                                          //   ],
                                          // );
                                        } else if (state is ServerMessagesLoaded){
                                          if (state.isLoadMoreAvaiable) {
                                            body = Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ActionButton(
                                                  name: 'Загрузить еще',
                                                  widthSize: 170,
                                                  onTap: () => context.read<ServerMessagesBloc>().add(ServerMessagesLoadMore(state.messages.length))
                                                )
                                              ],
                                            );
                                          } else {
                                            body = state.messages.isNotEmpty ? Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 24),
                                              child: Text(
                                                'Данных больше нет',
                                                style: AppStyles.headingTableTextStyle
                                              ),
                                            ) : Container();
                                          }
                                        }
                                        return SizedBox(
                                          // width: 1000,
                                          height: 64,
                                          child: body,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }
                        )
                      ),
                    ],
                  );
                }
                return body;
              }
            ),
          ),
        ],
      ),
    ),
  );


  Future<void> _onAddServerMessageTap() async {
    if(_addIsAvaliable) {
      final newServerMessage = await Navigation.toMessageAdd();
      if(newServerMessage != null) {
        context.read<ServerMessagesBloc>().add(ServerMessagesNewServerMessage(newServerMessage)); 
        _onLoadInfo();
      }
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.postIsNotAvaliableServerMessage,
        type: DialogType.info
      );            
    }
  }
  
  Future<void> _onEditTap(ServerMessage message) async {
    if(_editIsAvaliable) {
      final updatedMesssage = await Navigation.toMessageEdit(message);
      if (updatedMesssage != null) {
        context.read<ServerMessagesBloc>().add(ServerMessagesIncomeUpdateMessage(updatedMesssage));
      } 
      _onLoadInfo();
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableServerMessage,
        type: DialogType.info
      );           
    }
  }

  void _onViewTap(ServerMessage message)  {
    Navigation.toMessage(message);
    _onLoadInfo();
  }

  void _onSortTap(
    ServerMessageSort sort,
    bool sortAscending,
    int loadCount,
  ) {
    context.read<ServerMessagesBloc>().add(ServerMessagesLoad(
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      statusName: _selectedStatus,
      title: _titleController.text,
      text: _textController.text,
      sort: sort,
      sortAscending: sortAscending,
      loadCount: loadCount,
    ));
  }

  void _onSearchTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<ServerMessagesBloc>().add(ServerMessagesLoad(
        dateFrom: _dateFrom ?? DateTime(2000),
        dateTo: _dateTo ?? DateTime.now(),
        statusName: _selectedStatus,
        title: _titleController.text,
        text: _textController.text,
      ));
    }
  }

  void _onDeleteTap(int serverMessageId) {
    if(_deleteIsAvaliable) {
      Multiplatform.showDecisionMessage(
        context: context,
        message: '',
        action: () => context.read<ServerMessagesBloc>().add(ServerMessagesDeleteMessage(serverMessageId)),
        dialogTitle: 'Уверены, что хотите удалить рассылку?',
        buttonTitle: 'Удалить',
        cancelButtonTitle: 'Нет'
      );
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.deleteIsNotAvaliableServerMessage,
        type: DialogType.info
      );       
    }
  }

  void _onLoadInfo() {
    context.read<ServerMessagesBloc>().add(ServerMessagesLoad(
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      status: _selectedStatus,
      title: _titleController.text,
      text: _textController.text,
    ));
  }
}