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

class UserAddScreen extends StatefulWidget {
  static const pageName = 'Создание пользователя';

  @override
  _UserAddScreenState createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _focusNodes = List.generate(3, (_) => FocusNode());
  final _parentFieldKeys = List.generate(3, (index) => Key('field $index'));
  final _fieldKeys = List.generate(3, (_) => GlobalKey<FormFieldState>());

  UserType? _selectedUserType;
  Supplier? _selectedSupplier;
  bool enableAdmField = true;
  double width = 800;
  final _user = UserInsertRequest();


  @override
  void initState() {
    super.initState();
    _focusNodes.forEachIndexed((node, index) {
      node.addListener(() {
        if (!_focusNodes[index].hasFocus) {
          _fieldKeys[index].currentState?.validate();
        }
      });
    });
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<UserInsertBloc, UserInsertState>(
    listener: (context, state) {
      if (state is UserInsertError) {
        RequestUtil.catchNetworkError(context: context, obj: state.error);
      } else if (state is UserInsertSuccess) {
        if(Navigator.of(context).canPop()) {
          Navigator.of(context).pop<User>(state.user);    
        } else {
          Navigation.toUsers();     
        }
        Multiplatform.showMessage(
          context: context,
          title: 'Успешно',
          message: 'Пользователь id:${state.user?.id} добавлен',
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
              title: 'Создание пользователя',
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<UserInsertBloc, UserInsertState>(
                buildWhen: (prev, next) {
                  if (next is UserInsertInitial) return true;
                  if (next is UserInsertInitLoading) return true;
                  if (next is UserInsertInitError) return true;
                  return false;
                },
                builder: (context, state) {
                  Widget body = Container();
                  if (state is UserInsertInitError) {
                    body = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: double.maxFinite),
                        const Text('Невозможно начать процедуру создания'),
                        const SizedBox(height: 8),
                        CupertinoButton(
                          onPressed: () => context
                              .read<UserInsertBloc>()
                              .add(UserInsertInit()),
                          child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                        )
                      ],
                    );
                  } else if (state is UserInsertInitLoading) {
                    body = const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.maxFinite),
                        LoadingIndicator()
                      ],
                    );
                  } else if (state is UserInsertInitial) {
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
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          labelText: 'Дата создания',
                                          isReadOnly: true,
                                          initialValue: DateTime.now().toStringFormatted(),
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          key: _parentFieldKeys[0],
                                          fieldKey: _fieldKeys[0],
                                          focusNode: _focusNodes[0],
                                          labelText: 'ФИО',
                                          mandatory: true,
                                          maxLength: 128,
                                          onSaved: (value) {
                                            _user.name = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          key: _parentFieldKeys[1],
                                          fieldKey: _fieldKeys[1],
                                          focusNode: _focusNodes[1],
                                          labelText: 'Логин',
                                          mandatory: true,
                                          maxLength: 128,
                                          onSaved: (value) {
                                            _user.login = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: EmailTextField(
                                          key: _parentFieldKeys[2],
                                          fieldKey: _fieldKeys[2],
                                          focusNode: _focusNodes[2],
                                          onSaved: (value) {
                                            _user.email = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrTextField(
                                          labelText: 'Телефон',
                                          maxLength: 64,
                                          onSaved: (value) {
                                            _user.phoneNumber = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: TextFieldDropdownSearch<UserType>(
                                          title: 'Роль *',
                                          showSearchBox: false,
                                          maxHeight: 150,
                                          items: state.types,
                                          itemBuilder: (item) => item.description,
                                          selected: _selectedUserType,
                                          onTap: (item) {
                                            _selectedUserType = item;
                                            setState(() {
                                             enableAdmField = !_selectedUserType!.name.contains('ADMIN_ADMIN');
                                             if(enableAdmField) {
                                              
                                             }
                                            });
                                          },
                                          validator: () {
                                            if (_selectedUserType == null) {
                                              return 'Выберите роль';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            _user.typeId = value?.id;
                                          },
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child:enableAdmField? Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child:TextFieldDropdownSearch<Supplier>(
                                          title: 'Организация *',
                                          items: state.suppliers,
                                          itemBuilder: (item) => '${item.unp}, ${item.name}',
                                          selected: _selectedSupplier,
                                          onTap: (item) => _selectedSupplier = item,
                                          onSaved: (item) {
                                            _user.supplierId = _selectedSupplier?.id.toString();
                                          },
                                          validator: () {
                                            if (_selectedSupplier == null) {
                                              return 'Выберите организацию';
                                            }
                                            return null;
                                          },
                                        ),
                                      ): Container(),
                                    ),
                                    Div(
                                      colL: 6,
                                      colM: 12,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: AttrLogic(
                                          value: _user.blocked,
                                          onChanged: (value) => setState(() => _user.blocked = value),
                                          text: 'Заблокирован',
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                              )
                            ),
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
                        Navigation.toUsers();
                      }
                  }),       
                  const SizedBox(width: 10),
                  AddUserButton(
                    onTap: _onSaveTap,
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ),
  );

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      //_user.supplierId = _selectedSupplier?.id.toString();
      context.read<UserInsertBloc>().add(UserInsertRun(_user));
    }
  }
}