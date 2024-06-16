import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/widgets.dart';

class MessageEditScreen extends StatefulWidget {
  static const pageName = 'Редактирование уведомления';

  @override
  _MessageEditScreenState createState() => _MessageEditScreenState();
}

class _MessageEditScreenState extends State<MessageEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _focusNode =  FocusNode();

  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  final _searchSuppliersController = TextEditingController();

  DateTime? _sendingDate;
  DateTime? _sendingTime;

  bool _suppliersShown = false;
  bool _selectedAll = false;
  double width = 800;
  ServerMessage? _message;
  final _messageUpdate = ServerMessageUpdateRequest();

  List<Supplier> _selectedSuppliers = [];

  bool get isSaveAvailable {
    if (_message == null) return false;
    return (_selectedSuppliers.map<int>((e) => e.id).toList()) != _message!.supplierId ||
    (_sendingDate?.toStringFormattedGetOperationHistory() ?? '') != (_message!.sendingDate ?? '');
  }

  bool get isSendAvailable {
    if (_message == null) return false;
    return _messageUpdate.sendingImmediately 
    || _sendingDate != null;
    // (_selectedSuppliers.map<int>((e) => e.id).toList()) != _message!.supplierId
    // ||(_sendingDate?.toStringFormattedGetOperationHistory() ?? '') != (_message!.sendingDate ?? '');
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() { 
      if(_focusNode.hasFocus) {
        setState(() {
            _suppliersShown = true;
        });
      } 
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _titleController.dispose();
    _textController.dispose();
    _searchSuppliersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CommonAppBar(
                  title: 'Редактирование уведомления',
                ),
                const Divider(),
                Expanded(
                  child: BlocConsumer<ServerMessageUpdateBloc, ServerMessageUpdateState>(
                    listener: (context, state) {
                      if (state is ServerMessageUpdateInitial) {
                        _message = state.message;
                        _selectedSuppliers = state.suppliers.where((e) => state.message.supplierId?.contains(e.id) ?? false).toList();
                        _titleController.text = state.message.heading ?? '';
                        _textController.text = state.message.note ?? '';
                      } else if (state is ServerMessageUpdateSuccess) {
                          if(Navigator.of(context).canPop()) {
                            Navigator.of(context).pop<ServerMessage>(state.message);
                          } else {
                            Navigation.toOrganizations();     
                          }
                        Multiplatform.showMessage(
                          context: context,
                          title: 'Успешно',
                          message: 'Уведомление отредактировано',
                          type: DialogType.success
                        );
                      } else if (state is ServerMessageUpdateError) {
                        RequestUtil.catchNetworkError(
                          context: context,
                          obj: state.error
                        );
                      }
                    },
                    buildWhen: (prev, next) {
                      if (next is ServerMessageUpdateInitial) return true;
                      if (next is ServerMessageUpdateInitLoading) return true;
                      if (next is ServerMessageUpdateInitError) return true;
                      return false;
                    },
                    builder: (context, state) {
                      Widget body = Container();
                      if (state is ServerMessageUpdateInitError) {
                        body = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: double.maxFinite),
                            const Text('Невозможно отредактировать уведомление'),
                            const SizedBox(height: 8),
                            CupertinoButton(
                              onPressed: () => context
                                  .read<ServerMessageUpdateBloc>()
                                  .add(ServerMessageUpdateInit()),
                              child: const Text('Попробовать снова'),
                            )
                          ],
                        );
                      } else if (state is ServerMessageUpdateInitLoading) {
                        body = const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: double.maxFinite),
                            LoadingIndicator()
                          ],
                        );
                      } else if (state is ServerMessageUpdateInitial) {
                        body = SingleChildScrollView(
                          child: Center(
                            child: ResponsiveBuilder(
                              builder: (context, sizingInformation) {
                                if (sizingInformation.isMobile || sizingInformation.isTablet) {
                                  width = sizingInformation.screenSize.width;
                                }
                                return Container(
                                  width: width,
                                  padding: const EdgeInsets.symmetric(vertical: 32),
                                  child: Form(
                                    key: _formKey,
                                    child: Responsive(
                                      runSpacing: 16,
                                      children: [
                                        Div(
                                          colL: 12,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                            child: Text(
                                              'Уведомление',
                                              style: AppStyles.headerTextStyleLess,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                        ),
                                         Div(
                                          colL: 6,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: AttrTextField(
                                            labelText: 'Дата и время создания',
                                            isReadOnly: true,
                                            initialValue:  state.message.date?.toStringFormattedRunOperation() ?? '' //DateTime.now().toStringFormattedRunOperation(),
                                           ),
                                          ),
                                         ),
                                         Div( 
                                          colL: 6,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: AttrTextField(
                                            labelText: 'Статус',
                                            isReadOnly: true,
                                            initialValue: state.message.statusName ?? '', 
                                            ),
                                           ) ,
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                              child: AttrTextField(
                                                controller: _titleController,
                                                labelText: 'Заголовок',
                                                mandatory: true,
                                                maxLength: 128,
                                                onChanged: (_) => setState(() {}),
                                                onSaved: (value) {
                                                  if((_message!.heading ?? '') != value){
                                                    _messageUpdate.heading  = value;
                                                    } else {
                                                    _messageUpdate.heading = null;
                                                    }
                                                  },
                                              ),
                                            ),
                                          ),
                                          Div(
                                          colL: 6,
                                          colM: 12,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                            child: AttrTextField(
                                              controller: _textController,
                                              labelText: 'Текст',
                                              mandatory: true,
                                              maxLength: 4000,
                                              maxLines: 20,
                                              onChanged: (_) => setState(() {}),
                                              onSaved: (value) {
                                                if((_message!.note ?? '') != value){
                                                  _messageUpdate.note  = value;
                                                 } else {
                                                  _messageUpdate.note = null;
                                                 }
                                                },
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 12,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Text(
                                                'Параметры',
                                                style: AppStyles.headerTextStyleLess,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child:  Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: WebDatePicker(
                                                      needValidation:_sendingDate !=null,
                                                      editable: !_messageUpdate.sendingImmediately,
                                                      initialValue: _sendingDate?.toStringFormatted() ?? '',
                                                      onChange: (value)  {
                                                        setState(() {
                                                            _sendingDate = value; 
                                                        });
                                                      },
                                                      validator: () {
                                                        if (_messageUpdate.sendingImmediately) return null;
                                                        if (_sendingDate == null) return null;
                                                        if (_sendingDate!.compareTo(DateTime.now().add(const Duration(days: -1))) < 1) {
                                                          return 'Дата отправки не может \nбыть в прошлом';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  SizedBox(
                                                    width: 120,
                                                    child: AttrTimePrimary(
                                                      needValidation: _sendingTime != null,
                                                      editable: !_messageUpdate.sendingImmediately,
                                                      labelText: '',
                                                      initialValue: _sendingTime?.toStringFormattedHoursOnly() ?? '',
                                                      onChangeDate: (value) {
                                                        setState(() {
                                                          _sendingTime = value;
                                                        });
                                                      },
                                                      onSaved: (value) {
                                                        _sendingTime = value;
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                             ),
                                           ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                              child: AttrLogic(
                                                value: _messageUpdate.sendingImmediately,
                                                onChanged: (value) => setState(() => _messageUpdate.sendingImmediately = value),
                                                text: 'Отправить немедленно',
                                                padding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 12,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Text(
                                                'Адресаты. Выбрано ${_selectedSuppliers.length}',
                                                style: AppStyles.headerTextStyleLess,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 6,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrTextField(
                                                focusNode: _focusNode,
                                                controller: _searchSuppliersController,
                                                onChanged: (_) => setState(() {}),
                                                labelText: 'Поиск',
                                                hint: 'Название или УНП',
                                              ),
                                            ),
                                          ),
                                          Div(
                                            colL: 4,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: AttrLogic(
                                                value: _selectedAll,
                                                onChanged: (value) => setState(() {
                                                    _selectedAll = value;
                                                    if(_selectedSuppliers.length != state.suppliers.length) {
                                                      if(_selectedSuppliers.isEmpty) {
                                                        _selectedSuppliers.addAll(state.suppliers);
                                                      } else {
                                                        _selectedSuppliers
                                                        ..clear()
                                                        ..addAll(state.suppliers);
                                                      }
                                                    } else {
                                                      _selectedSuppliers.clear();
                                                    }
                                                }),
                                                text: 'Выбрать все',
                                                padding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                          if(_suppliersShown)
                                          Div(
                                            colL: 4,
                                            colM: 12,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Wrap(
                                                direction: Axis.vertical,
                                                spacing: 5,
                                                runSpacing: 10,
                                                // ignore: avoid_bool_literals_in_conditional_expressions
                                                children: state.suppliers.where((e) => _searchSuppliersController.text.isEmpty
                                                  ? true
                                                  : e.unp!.contains(_searchSuppliersController.text) || e.name!.toLowerCase().contains(_searchSuppliersController.text.toLowerCase())).map((e) => 
                                                  ChoiceChip(
                                                  selected: _selectedSuppliers.contains(e),
                                                  selectedColor: AppStyles.mainColor,
                                                  backgroundColor: Colors.transparent,
                                                  label: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      if (_selectedSuppliers.contains(e))
                                                      const Padding(
                                                        padding: EdgeInsets.only(right: 4),
                                                        child: Icon(Icons.check, color: Colors.white),
                                                      ),
                                                      Text('${e.unp}, ${e.name}', style: TextStyle(color: _selectedSuppliers.contains(e)? Colors.white:null)),
                                                    ],
                                                  ),
                                                  onSelected: (value) {
                                                    if (value) {
                                                      _selectedSuppliers.add(e);
                                                    } else {
                                                      _selectedSuppliers.remove(e);
                                                      if(_selectedAll){
                                                        setState(() {
                                                          _selectedAll = false;
                                                        });
                                                      }
                                                    }
                                                    setState(() {});
                                                  },
                                                )).toList(),
                                              ),
                                            ),
                                          ),      
                                      ],
                                    ),
                                  ),
                                );
                              }
                            )
                          )
                        );
                      }
                      return body;
                    }
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      UndoButton(onTap: () {
                        if(Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          } else {
                            Navigation.toOrganizations();
                          }
                      }),
                      const SizedBox(width: 5),
                      SaveButton(
                        onTap: _onSaveTap,
                        isAvaible: !isSaveAvailable
                      ),
                      const SizedBox(width: 5),
                      SaveServiceMessageButton(
                        onTap: _onSendTap,
                        isAvailable: isSendAvailable,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]
      )
    )
  );

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if(_messageUpdate.sendingImmediately){
        _messageUpdate.sendingDate = DateTime.now();
      } else {
        if(_sendingDate != null && _sendingTime != null) {
          _messageUpdate.sendingDate = DateTime(_sendingDate!.year, _sendingDate!.month, _sendingDate!.day, _sendingTime!.hour, _sendingTime!.minute);
        } else {
          _messageUpdate.sendingDate = null;
        }
         
      }
      context.read<ServerMessageUpdateBloc>().add(ServerMessageUpdateRun(_messageUpdate));
    }
  }

  void _onSendTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if(_messageUpdate.sendingImmediately){
        _messageUpdate.sendingDate = DateTime.now();
      } 
      else {
        if(_sendingDate != null && _sendingTime != null) {
          _messageUpdate.sendingDate = DateTime(_sendingDate!.year, _sendingDate!.month, _sendingDate!.day, _sendingTime!.hour, _sendingTime!.minute);
        } else {
          _messageUpdate.sendingDate = null;
        }
        
      }
      context.read<ServerMessageUpdateBloc>().add(ServerMessageUpdateRun(_messageUpdate));
    }
  }
}