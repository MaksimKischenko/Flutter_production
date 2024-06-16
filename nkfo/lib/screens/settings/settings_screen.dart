import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  static const pageName = 'Настройки';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> _pages = [
    'Настройка полей',
    'Настройка сообщения',
    'Смена пароля', 
  ];

  int _selectedPage = 0;
  bool _isChangePasswordAvailable = true;
  bool _isSaveMessageAvailable = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CabinetMenu(
            selectedIndex: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _pages.mapIndexed((e, index) => SideMenuItem(
                        text: e,
                        onTap: () {
                          switch (index) {
                            case 0:
                              _verifyPermissionsOnTap(
                                index: 0, 
                                isAvailable: true,
                                message: ''
                              );
                            break;
                            case 1:
                              _verifyPermissionsOnTap(
                                index: 1, 
                                isAvailable: _isSaveMessageAvailable,
                                message: AppConfig.sendMessageIsNotAvaliable
                              );
                              break;
                            case 2:
                              _verifyPermissionsOnTap(
                                index: 2, 
                                isAvailable: _isChangePasswordAvailable,
                                message: AppConfig.changePasswordIsNotAvaliable              
                              );
                              break;
                          }
                        }, 
                        selected: index == _selectedPage,
                      )).toList()
                    ),
                  ),
                  const SizedBox(width: 32),
                  if (_selectedPage == 0)
                  Expanded(
                    child: BlocBuilder<SettingsBloc, SettingsState>(
                      builder: (context, state) {
                        if (state is SettingsInitial) {
                          _isChangePasswordAvailable = state.isChangePasswordAvailable;    
                          _isSaveMessageAvailable = state.isStartMessageAvailable;        
                          return SingleChildScrollView(
                            child: ResponsiveBuilder(
                              builder: (context, sizingInformation) {
                                var width = 800.0;
                                if (sizingInformation.isMobile || sizingInformation.isTablet) {
                                  width = sizingInformation.screenSize.width;
                                }
                                return SizedBox(
                                  width: width,
                                  child: Responsive(
                                    runSpacing: 16,
                                    children: [
                                      _fieldsGroup<SuppliersSort>(
                                        name: 'Организации',
                                        selectedList: state.supplierItems,
                                        fullList: SuppliersSort.values,
                                        onChanged: (item, value) => context.read<SettingsBloc>().add(SettingsChanged(
                                          supplierItem: item,
                                          value: value
                                        )),
                                        itemNameBuilder: (item) => item.name
                                      ),
                                      _fieldsGroup<UsersSort>(
                                        name: 'Пользователи',
                                        selectedList: state.userItems,
                                        fullList: UsersSort.values,
                                        onChanged: (item, value) => context.read<SettingsBloc>().add(SettingsChanged(
                                          userItem: item,
                                          value: value
                                        )),
                                        itemNameBuilder: (item) => item.name
                                      ),
                                      _fieldsGroup<AuditSort>(
                                        name: 'Журнал аудита',
                                        selectedList: state.auditItems,
                                        fullList: AuditSort.values,
                                        onChanged: (item, value) => context.read<SettingsBloc>().add(SettingsChanged(
                                          auditItem: item,
                                          value: value
                                        )),
                                        itemNameBuilder: (item) => item.name
                                      ),
                                      _fieldsGroup<ServerMessageSort>(
                                        name: 'Рассылки',
                                        selectedList: state.serverMessageItems,
                                        fullList: ServerMessageSort.values,
                                        onChanged: (item, value) => context.read<SettingsBloc>().add(SettingsChanged(
                                          serverMessageItem: item,
                                          value: value
                                        )),
                                        itemNameBuilder: (item) => item.name
                                      ),
                                    ],
                                  )
                                );
                              }
                            ),
                          );
                        } else {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: LoadingIndicator()
                              ),
                            ],
                          ); 
                        }
                      }
                    ),
                  ),
                  if (_selectedPage == 1)
                  MessageItem()
                  else if (_selectedPage == 2)
                  ChangePasswordItem()
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );


  void _verifyPermissionsOnTap({
    required bool isAvailable, 
    required int index, 
    required String message
    }) {
      if(isAvailable) {
         setState(() => _selectedPage = index);
      } else {
        Multiplatform.showMessage(
          context: context,
          title: 'Операция отклонена',
          message: message,
          type: DialogType.info
        );  
      }
  }

  Widget _fieldsGroup<T>({
    required String name,
    required List<T> selectedList,
    required List<T> fullList,
    required Function(T item, bool value) onChanged,
    required String Function(T item) itemNameBuilder
  }) => Div(
    colL: 6,
    colM: 12,
    child: Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          name, 
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          )
        ),
        children: fullList.map((e) {
          final value = selectedList.contains(e);
          return CheckboxListTile(
            value: value,
            onChanged: selectedList.length > 1 || (selectedList.length == 1 && !value)
            ? (newValue) => onChanged(e, newValue ?? false) : null,
            title: Text(itemNameBuilder(e)),
          );
        }).toList(),
      ),
    ),
  );
}