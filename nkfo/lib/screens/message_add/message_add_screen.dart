// ignore_for_file: avoid_bool_literals_in_conditional_expressions

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

class MessageAddScreen extends StatefulWidget {
  static const pageName = 'Создание уведомления';

  @override
  _MessageAddScreenState createState() => _MessageAddScreenState();
}

class _MessageAddScreenState extends State<MessageAddScreen> {
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
  
  
  final _message = ServerMessageInsertRequest();

  final List<Supplier> _selectedSuppliers = [];

  bool get isSaveAvailable => //_selectedSuppliers.isNotEmpty
    _titleController.text.isNotEmpty
    && _textController.text.isNotEmpty;

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
  Widget build(BuildContext context) => BlocListener<ServerMessageInsertBloc, ServerMessageInsertState>(
    listener: (context, state) {
      if (state is ServerMessageInsertError) {
        RequestUtil.catchNetworkError(context: context, obj: state.error);
      } else if (state is ServerMessageInsertSuccess) {
          if(Navigator.of(context).canPop()) {
            Navigator.of(context).pop<ServerMessage>(state.message);      
          } else {
            Navigation.toMessages();     
          }
        Multiplatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Уведомление id:${state.message?.id} добавлено',
          type: DialogType.success
        );
      }
    },
    child: Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonAppBar(
              title: 'Создание уведомления',
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<ServerMessageInsertBloc, ServerMessageInsertState>(
                buildWhen: (prev, next) {
                  if (next is ServerMessageInsertInitial) return true;
                  if (next is ServerMessageInsertInitLoading) return true;
                  if (next is ServerMessageInsertInitError) return true;
                  return false;
                },
                builder: (context, state) {
                  Widget body = Container();
                  if (state is ServerMessageInsertInitError) {
                    body = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: double.maxFinite),
                        const Text('Невозможно начать процедуру создания'),
                        const SizedBox(height: 8),
                        CupertinoButton(
                          onPressed: () => context
                              .read<ServerMessageInsertBloc>()
                              .add(ServerMessageInsertInit()),
                          child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                        )
                      ],
                    );
                  } else if (state is ServerMessageInsertInitLoading) {
                    body = const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.maxFinite),
                        LoadingIndicator()
                      ],
                    );
                  } else if (state is ServerMessageInsertInitial) {
                    body = SingleChildScrollView(
                      child: ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          if (sizingInformation.isMobile || sizingInformation.isTablet) {
                            width = sizingInformation.screenSize.width;
                          }
                          return Center(
                            child: Container(
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
                                        initialValue: DateTime.now().toStringFormattedRunOperation(),
                                       ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                        labelText: 'Статус',
                                        isReadOnly: true,
                                        initialValue: 'Черновик',
                                       ),
                                      ),
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
                                            _message.heading = value;
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
                                            _message.note = value;
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: WebDatePicker(
                                                needValidation: _sendingDate !=null,
                                                editable: !_message.sendingImmediately,
                                                initialValue: _sendingDate?.toStringFormatted() ?? '',
                                                onChange: (value) {
                                                  setState(() {
                                                    _sendingDate = value;
                                                  });
                                                },
                                                validator: () {
                                                  if (_message.sendingImmediately) return null;
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
                                                editable: !_message.sendingImmediately,
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
                                          value: _message.sendingImmediately,
                                          onChanged: (value) => setState(() => _message.sendingImmediately = value),
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
                                               } else if(_selectedSuppliers.isNotEmpty && _selectedAll){
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
                                          children: 
                                          state.suppliers.where((e) => _searchSuppliersController.text.isEmpty
                                            ? true
                                            : e.unp!.contains(_searchSuppliersController.text) || e.name!.toLowerCase().contains(_searchSuppliersController.text.toLowerCase())).map((e) => 
                                            ChoiceChip(
                                            selected: _selectedSuppliers.contains(e),
                                            selectedColor: AppStyles.mainColor, //.withOpacity(0.5),
                                            backgroundColor: Colors.transparent,   //AppStyles.mainTextColor.withOpacity(0.1),
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
                                )
                              )
                            )
                          );
                        }
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
                        Navigation.toMessages();  
                      }
                  }),
                  const SizedBox(width: 10),
                  SaveServiceMessageButton(
                    isSendingDateKnown: _message.sendingImmediately || (_sendingDate != null && _sendingTime != null),
                    onTap: _onSaveTap,
                    isAvailable: isSaveAvailable,
                  )
                ],
              ),
            ),
          ],
        )
      )
    ),
  );

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (_message.sendingImmediately) {
        _message.sendingDate = DateTime.now();
      } else {
        if(_sendingDate != null && _sendingTime != null) {
          _message.sendingDate = DateTime(_sendingDate!.year, _sendingDate!.month, _sendingDate!.day, _sendingTime!.hour, _sendingTime!.minute);
        } else {
          _message.sendingDate = null;
        }
        
      }
      _message.supplierId = _selectedSuppliers.map((e) => e.id).toList();
      context.read<ServerMessageInsertBloc>().add(ServerMessageInsertRun(_message));
    }
  }
}