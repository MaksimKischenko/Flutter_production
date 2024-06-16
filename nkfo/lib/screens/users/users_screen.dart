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
import 'package:web_cabinet_nkfo/screens/users/widgets/widgets.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';


class UsersScreen extends StatefulWidget {
  static const pageName = 'Пользователи';

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _formKey = GlobalKey<FormState>();

  UsersBlockStatus _selectedBlockStatus = UsersBlockStatus.all;

  UserType? _selectedType;
  Supplier? _selectedSupplier;

  final List<User> _selectedUsers = [];
  bool isActive = false;
  bool selectAll = false;
  String? emptyTableMessage;
  bool _addIsAvaliable = true;
  bool _editIsAvaliable = true;
  bool _deleteIsAvaliable = true;
  bool _resetPasswordIsAvaliable = true;

  final _fioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
    if (currentAuthState is AuthAuthorized) {
      context.read<UsersBloc>().add(UsersInit());
    } else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          context.read<UsersBloc>().add(UsersInit());
          _onLoadInfo();
        }
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _onLoadInfo());
  }

  @override
  void dispose() {
    _fioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CabinetMenu(
            selectedIndex: 1,
          ),
          Expanded(
            child: BlocConsumer<UsersBloc, UsersState>(
              listener: (context, state) {
                if (state is UsersError) {
                  if(!state.error.toString().contains('Http status error [401]')) {
                    RequestUtil.catchNetworkError(context: context, obj: state.error);
                  }
                } else if (state is UserGetNotAllow) {
                  setState(() {
                    emptyTableMessage = state.message;
                    _addIsAvaliable = false;
                    _deleteIsAvaliable = false;
                    _editIsAvaliable = false;
                    _resetPasswordIsAvaliable = false;
                  });                 
                } else if (state is UsersDeleteUserSuccess) {
                  isActive = false;
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Пользователь ${state.id} удален',
                    type: DialogType.success
                  );
                } else if (state is UsersDeleteGroupUserSuccess) {
                   isActive = false;
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Пользователи удалены',
                    type: DialogType.success
                  );
                } else if (state is UsersResetUserPasswordSuccess) {
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Пароль пользователя сброшен',
                    type: DialogType.success
                  );
                } else if (state is UsersChangeUserStatusSuccess) {
                  isActive = false;
                  selectAll = false;
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Признак блокировки изменен',
                    type: DialogType.success
                  );
                }
              },
              buildWhen: (prev, next) {
                if (next is UsersInitLoading) return true;
                if (next is UsersInitError) return true;
                if (next is UsersLoaded) return true;
                return false;
              },
              builder: (context, state) {
                Widget body = Container();
                if (state is UsersInitError) {
                    body = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: double.maxFinite),
                        const Text('Невозможно отобразить страницу пользователей'),
                        const SizedBox(height: 8),
                        CupertinoButton(
                          onPressed: () => context
                              .read<UsersBloc>()
                              .add(UsersInit()),
                          child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                        )
                      ],
                    );
                  } else if (state is UsersInitLoading) {
                    body = const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.maxFinite),
                        LoadingIndicator()
                      ],
                    );
                  } else if (state is UsersLoaded) {
                    _addIsAvaliable = state.postIsAvaliableUser;
                    _editIsAvaliable = state.patchIsAvaliableUser;
                    _deleteIsAvaliable = state.deleteIsAvaliableUser;
                    _resetPasswordIsAvaliable = state.resetPasswordIsAvaliableUser;
                    
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
                                Div(
                                  colL: 2,
                                  colM: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: TextFieldDropdownSearch<UsersBlockStatus>(
                                      title: 'Признак блокировки',
                                      showSearchBox: false,
                                      maxHeight: 150,
                                      items: UsersBlockStatus.values,
                                      itemBuilder: (item) => item.name,
                                      selected: _selectedBlockStatus,
                                      onTap: (item) => setState(() => _selectedBlockStatus = item),
                                    ),
                                  ),
                                ),
                                if (state.getIsAvaliableUserType) Div(
                                  colL: 2,
                                  colM: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: TextFieldDropdownSearch<UserType>(
                                      title: 'Роль',
                                      showSearchBox: false,
                                      maxHeight: 190,
                                      items: [UserType(id: -1, name: '', description: 'Все'),...state.types],
                                      editable: state.getIsAvaliableUserType,
                                      itemBuilder: (item) => item.description,
                                      selected: _selectedType,
                                      onTap: (item) => setState(() => _selectedType = item),
                                      onSaved: (item) {
                                        if ((item?.id ?? -1) == -1) {
                                          _selectedType = null;
                                        }
                                      },
                                      emptyMessage: 'Все',
                                    ),
                                  ),
                                ) else const SizedBox(),
                                if (state.getIsAvaliableSupplier) Div(
                                  colL: 2,
                                  colM: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: TextFieldDropdownSearch<Supplier>(
                                      title: 'Организация',
                                      items: [const Supplier(id: -1),...state.suppliers],
                                      editable: state.getIsAvaliableSupplier,
                                      itemBuilder: (item) => item.id == -1 ? 'Все' : '${item.unp}, ${item.name}',
                                      selected: _selectedSupplier,
                                      onTap: (item) => setState(() => _selectedSupplier = item),
                                      onSaved: (item) {
                                        if ((item?.id ?? -1) == -1) {
                                          _selectedSupplier = null;
                                        }
                                      },
                                    ),
                                  ),
                                ) else const SizedBox(),
                                Div(
                                  colL: 2,
                                  colM: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child:  AttrTextField(
                                      controller: _fioController,
                                      labelText: 'ФИО',
                                      helperText: 'без учета регистра',
                                    ),
                                  ),
                                ),
                                Div(
                                  colL: 2,
                                  colM: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SearchUsersButton(onTap: _onSearchTap),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            children: [
                              ActionButton(
                                onTap: _onAddUserTap
                              ),
                              const Spacer(),
                              Text('Действия с выбранными', style: AppStyles.infoTextStyle),
                              const SizedBox(width: 4),
                              DeleteGroupAction(
                                onTap: _onDeleteGroupUserTap,
                                isAvailable: isActive,
                              ),
                              const SizedBox(width: 4),
                              BlockGroupAction(
                                onTap: _onBlocGroupUserStatusTap,
                                isAvailable: isActive,
                              ),
                              const SizedBox(width: 4),
                              UnBlockGroupAction(
                                onTap: _onUnBlocGroupUserStatusTap,
                                isAvailable: isActive,
                              ),
                            ],
                          )
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
                                          sortColumnIndex: settingsState.userItems.indexOf(state.sort) + 1,
                                          sortAscending: state.sortAscending,
                                          headingTextStyle: AppStyles.headingTableTextStyle,
                                          columnSpacing: 20,
                                          dataRowColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                            if(states.contains(MaterialState.selected)) {
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
                                              BlocBuilder<UsersBloc, UsersState>(
                                                builder: (context, state) {
                                                  Widget emtyTableBody = Container();
                                                  if(state is UsersLoading) {
                                                    emtyTableBody = const LoadingIndicator(
                                                      indicatorsSize: 80,
                                                    );
                                                  } else if(state is UserGetNotAllow) {
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
                                             DataColumn2(
                                              label: AttrLogic(
                                                value: selectAll,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectAll = value;
                                                    if(selectAll) {
                                                      //To avoid double adding of elements 
                                                      _selectedUsers.addAll(state.users.where((element) => element.typeId != 1 && !_selectedUsers.contains(element)));
                                                      isActive = true;
                                                    } else {
                                                      _selectedUsers.clear();
                                                      isActive = false;
                                                    }
                                                  });
                                                },
                                                text: '',
                                                padding: EdgeInsets.zero,
                                              ),
                                              numeric: true,
                                              size: ColumnSize.S,
                                            ),
                                            ...settingsState.userItems.map((e) => DataColumn2(
                                              label: Text(e.name),
                                              size: e.columnSize,
                                              onSort: (_, ascending) => _onSortTap(e, ascending, state.users.length)
                                            )).toList(),
                                            DataColumn2(
                                              label: Container(),
                                              numeric: true,
                                              size: ColumnSize.S,
                                            ),
                                          ],
                                          rows: [
                                            // ...state.users.where((element) => element.typeId == 1), 
                                            // ...state.users.where((element) => element.typeId == 2),
                                            // ...state.users.where((element) => element.typeId == 3),
                                            // ...state.users.where((element) => element.typeId == 4),
                                            ...state.users
                                          ].mapIndexed((e, index) => 
                                          DataRow(
                                            selected: _selectedUsers.contains(e),
                                            cells: [
                                              DataCell(
                                                Center(
                                                  child: AttrLogic(
                                                    editable: e.typeId != 1,
                                                    text: '',
                                                    value: _selectedUsers.contains(e),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        isActive = true;                                                        
                                                        if(!_selectedUsers.contains(e)) {
                                                          _selectedUsers.add(e);
                                                        } 
                                                        else {
                                                          _selectedUsers.remove(e);
                                                          if(_selectedUsers.isEmpty) {
                                                            isActive = false;
                                                          }
                                                        }
                                                      });
                                                    },
                                                  ) 
                                              )),
                                              if (settingsState.userItems.contains(UsersSort.name))
                                              DataCell(SelectableText(e.name ?? 'Неизвестно')),
                                              if (settingsState.userItems.contains(UsersSort.login))
                                              DataCell(SelectableText(e.login ?? 'Неизвестно')),
                                              if (settingsState.userItems.contains(UsersSort.email))
                                              DataCell(SelectableText(e.email ?? 'Неизвестно')),
                                              if (settingsState.userItems.contains(UsersSort.phoneNumber))
                                              DataCell(SelectableText(e.phoneNumber ?? 'Неизвестно')),
                                              if (settingsState.userItems.contains(UsersSort.role))
                                              DataCell(SelectableText(e.typeDescription ?? 'Неизвестно')),
                                              if (settingsState.userItems.contains(UsersSort.supplierUnp))
                                              DataCell(SelectableText(e.supplierUnp ?? 'Неизвестно')),
                                              if (settingsState.userItems.contains(UsersSort.supplierName))
                                              DataCell(SelectableText(e.supplierName ?? 'Неизвестно')),
                                              if (settingsState.userItems.contains(UsersSort.blocked))
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
                                                    child: SelectableText(
                                                      e.blockedName ?? 'Неизвестно',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: AppStyles.mainColorDark),
                                                      // overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              if (settingsState.userItems.contains(UsersSort.dateAdd))
                                              DataCell(SelectableText(e.dateAdd!.toStringFormatted())),
                                              DataCell(PopupMenuButton<UserActionType>(
                                                onSelected: (value) {
                                                  switch (value) {
                                                    case UserActionType.edit:
                                                      _onEditUserTap(e);
                                                      break;
                                                    case UserActionType.block:
                                                      _onChangeUserStatusTap(
                                                        id: e.id,
                                                        blocked: e.blocked,
                                                      );
                                                      break;
                                                    case UserActionType.delete:
                                                      _onDeleteUserTap(e.id);
                                                      break;
                                                    case UserActionType.resetPassword:
                                                      _onResetUserPasswordTap(e.login ?? '');
                                                      break;
                                                  }
                                                },
                                                itemBuilder: (BuildContext context) => UserActionType.values.map<PopupMenuItem<UserActionType>>((action) 
                                                => PopupMenuItem<UserActionType>(
                                                  value: action,
                                                  child: Text(action.name(blocked: e.blocked)),
                                                )).toList(),
                                                child: const Icon(
                                                  Icons.more_horiz_rounded,
                                                  size: 16,
                                                ),
                                              )),
                                            ]
                                          )).toList(),
                                        ),
                                      ),
                                      RowCounter(state.users.length),
                                      BlocBuilder<UsersBloc, UsersState>(
                                        builder: (context, state) {
                                          Widget body = Container();
                                          if (state is UsersLoading) {

                                          } else if (state is UsersLoaded){
                                            if (state.isLoadMoreAvaiable) {
                                              body = Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  ActionButton(
                                                    name: 'Загрузить еще',
                                                    widthSize: 170,
                                                    onTap: () => context.read<UsersBloc>().add(UsersLoadMore(state.users.length))
                                                  )                                                  
                                                ],
                                              );
                                            } else {
                                              body = state.users.isNotEmpty ? Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 24),
                                                child: Text(
                                                    'Данных больше нет',
                                                    style: AppStyles.headingTableTextStyle,
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
                          ),
                        )
                      ]
                    );
                  }
                return body;
              },
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> _onAddUserTap() async {
    if(_addIsAvaliable) {
      final newUser = await Navigation.toUsersAdd();
      context.read<UsersBloc>().add(UsersNewUser(newUser!));
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.postIsNotAvaliableUser,
        type: DialogType.info
      );             
    }
  } 

  void _onSortTap(
    UsersSort sort,
    bool sortAscending,
    int loadCount
  ) {
    context.read<UsersBloc>().add(UsersLoad(
      blockStatus: _selectedBlockStatus,
      type: _selectedType,
      supplierId: _selectedSupplier?.id,
      fio: _fioController.text,
      sort: sort,
      sortAscending: sortAscending,
      loadCount: loadCount,
    ));
  }

  void _onSearchTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<UsersBloc>().add(UsersLoad(
        blockStatus: _selectedBlockStatus,
        type: _selectedType,
        supplierId: _selectedSupplier?.id,
        fio: _fioController.text,
      ));
    }
  }

  void _onLoadInfo() {
    context.read<UsersBloc>().add(UsersLoad(
        blockStatus: _selectedBlockStatus,
        type: _selectedType,
        supplierId: _selectedSupplier?.id,
        fio: _fioController.text,
    ));
  }


  Future<void> _onEditUserTap(User user) async {
    if(_editIsAvaliable) {
      final updatedUser = await Navigation.toUsersEdit(user: user);
      if (updatedUser != null) {
        context.read<UsersBloc>().add(UsersUpdateUser(updatedUser));
      }
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableUser,
        type: DialogType.info
      );  
    }
  }

  void _onChangeUserStatusTap({
    required int id,
    required bool blocked
  }) {
    if(_editIsAvaliable) {
      context.read<UsersBloc>().add(UsersChangeUserStatus(
        id: id,
        blocked: blocked,
      )); 
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableUser,
        type: DialogType.info
      );             
    }
  }

  void _onBlocGroupUserStatusTap() {
    if(_editIsAvaliable) {
      context.read<UsersBloc>().add(UsersChangeGroupUserStatus(
        userIds: _selectedUsers.map((e) => e.id).toList(),
        blocked: true  //_selectedStatuses.every((element) => true),
      ));
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableUser,
        type: DialogType.info
      );  
    }
    _selectedUsers.clear();
  }

    void _onUnBlocGroupUserStatusTap() {
    if(_editIsAvaliable) {
      context.read<UsersBloc>().add(UsersChangeGroupUserStatus(
        userIds: _selectedUsers.map((e) => e.id).toList(),
        blocked:  false                     //_selectedStatuses.every((element) => false),
      ));
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableUser,
        type: DialogType.info
      );  
    }
    _selectedUsers.clear();
  }

  void _onDeleteUserTap(int userId) {
    if(_deleteIsAvaliable) {
      Multiplatform.showDecisionMessage(
        context: context,
        message: '',
        action: () => context.read<UsersBloc>().add(UsersDeleteUser(userId)),
        dialogTitle: 'Уверены, что хотите удалить пользователя?',
        buttonTitle: 'Удалить',
        cancelButtonTitle: 'Нет'
      );
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.deleteIsNotAvaliableUser,
        type: DialogType.info
      );                 
    }
  }

  void _onDeleteGroupUserTap() {
    if(_deleteIsAvaliable) {
      Multiplatform.showDecisionMessage(
        context: context,
        message: '',
        action: () => context.read<UsersBloc>().add(UsersDeleteGroupUser(
           _selectedUsers.map((e) => e.id).toList()
        )),
        dialogTitle: 'Уверены, что хотите удалить выбранных пользователей?',
        buttonTitle: 'Удалить',
        cancelButtonTitle: 'Нет'
      );
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.deleteIsNotAvaliableUser,
        type: DialogType.info
      );  
    }
  }

  void _onResetUserPasswordTap(String userLogin) {
    if(_resetPasswordIsAvaliable) {
      context.read<UsersBloc>().add(UsersResetUserPassword(userLogin));
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.resetPasswordIsNotAvaliableUser,
        type: DialogType.info
      );          
    }
  }
}
