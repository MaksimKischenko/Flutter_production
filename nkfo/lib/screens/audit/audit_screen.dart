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
import 'package:web_cabinet_nkfo/screens/audit_archive.dart/widgets/archive_button.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/widgets.dart';

class AuditScreen extends StatefulWidget {
  static const pageName = 'Журнал аудита';

  @override
  _AuditScreenState createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _dateFrom;
  DateTime? _dateTo;
  AuditApplication? _selectedApplication;
  AuditAction? _selectedAction;
  Supplier? _selectedSupplier;
  String? emptyTableMessage;
  bool _getIsAvialableAudit = true;
  bool _archiveIsAvaliableAudit = true;

  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
    if (currentAuthState is AuthAuthorized) {
      context.read<AuditBloc>().add(AuditInit());
    } else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          context.read<AuditBloc>().add(AuditInit());
        }
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => Future.delayed(const Duration(milliseconds: 500), _onLoadInfo));
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CabinetMenu(
            selectedIndex: 2,
          ),
          Expanded(
            child: BlocConsumer<AuditBloc, AuditState>(
              listener: (context, state) {
                if (state is AuditError) {
                  if(!state.error.toString().contains('Http status error [401]')) {
                     RequestUtil.catchNetworkError(context: context, obj: state.error);
                  }
                } else if (state is AuditExportSuccess) {
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Лог ${state.fileName} с ${state.rowCount} ${state.rowCount.plural("запись", "записями", "записями")} выгружен',
                    type: DialogType.success
                  );
                } else if (state is AuditGetNotAllow) {
                  setState(() {
                    emptyTableMessage = state.message;
                    _archiveIsAvaliableAudit = false;
                  });                 
                }
              },
              buildWhen: (prev, next) {
                if (next is AuditInitLoading) return true;
                if (next is AuditInitError) return true;
                if (next is AuditLoaded) return true;
                return false;
              },
              builder: (context, state) {
                Widget body = Container();
                if (state is AuditInitError) {
                  body = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: double.maxFinite),
                      const Text('Невозможно отобразить журнал аудита'),
                      const SizedBox(height: 8),
                      CupertinoButton(
                        onPressed: () => context
                            .read<AuditBloc>()
                            .add(AuditInit()),
                        child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                      )
                    ],
                  );
                } else if (state is AuditInitLoading) {
                  body = const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: double.maxFinite),
                      LoadingIndicator()
                    ],
                  );
                } else if (state is AuditLoaded) {
                  _getIsAvialableAudit = state.getIsAvaliableAudit;
                  _archiveIsAvaliableAudit = state.archiveIsAvaliableAudit;
                  body = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Form(
                          key: _formKey,
                          child: Responsive(
                            runSpacing: 16,
                            children:[
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
                                colM: 8,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFieldDropdownSearch<AuditApplication>(
                                    title: 'Приложение',
                                    showSearchBox: false,
                                    editable: state.getIsAvaliableAuditApplication,
                                    maxHeight: 150,
                                    items: [AuditApplication(name: null),...state.applications],
                                    itemBuilder: (item) => item.name == null ? 'Все' : '${item.name}',
                                    selected: _selectedApplication,
                                    onTap: (item) => setState(() => _selectedApplication = item),
                                    onSaved: (item) {
                                      if (item?.name == null) {
                                        _selectedApplication = null;
                                      }
                                    },
                                    emptyMessage: 'Все',
                                  ),
                                ),
                              ),
                              Div(
                                colL: 2,
                                colM: 8,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFieldDropdownSearch<AuditAction>(
                                    title: 'Тип события',
                                    showSearchBox: false,
                                    editable: state.getIsAvaliableAuditAction,
                                    items: [AuditAction(id: -1, name: ''),...state.actions],
                                    itemBuilder: (item) => item.id == -1 ? 'Все' : item.name,
                                    selected: _selectedAction,
                                    onTap: (item) => setState(() => _selectedAction = item),
                                    onSaved: (item) {
                                      if ((item?.id ?? -1) == -1) {
                                        _selectedAction = null;
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
                              ),
                              Div(
                                colL: 2,
                                colM: 6,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child:  AttrTextField(
                                    controller: _descriptionController,
                                    labelText: 'Описание',
                                    helperText: 'без учета регистра',
                                  ),
                                ),
                              ),
                              Div(
                                colL: 1,
                                colM: 6,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 10,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SearchAuditButton(onTap: _onSearchTap),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Row(
                          children: [
                            ExportButton(
                              onTap: _onRunExport
                            ),
                            const SizedBox(width: 10),
                            ArchiveButton(
                              onTap: _onRunAuditArchive
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
                                        sortColumnIndex: settingsState.auditItems.indexOf(state.sort),
                                        //sortColumnIndex: state.sort.index + 1,
                                        sortAscending: state.sortAscending,
                                        // headingRowColor: MaterialStateProperty.all(
                                        //   AppStyles.mainColor.withOpacity(0.2)
                                        // ),
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
                                            BlocBuilder<AuditBloc, AuditState>(
                                              builder: (context, state) {
                                                Widget emtyTableBody = Container();
                                                if(state is AuditLoading) {
                                                  emtyTableBody = const LoadingIndicator(
                                                    indicatorsSize: 80,
                                                  );
                                                } else if(state is AuditGetNotAllow) {
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
                                        columns: settingsState.auditItems.map((e) => DataColumn2(
                                          label: Text(e.name),
                                          size: e.columnSize,
                                          onSort: (_, ascending) => _onSortTap(e, ascending, state.audit.length)
                                        )).toList(),
                                        rows: state.audit.map((e) => DataRow(
                                          cells: [
                                            if (settingsState.auditItems.contains(AuditSort.date))
                                            DataCell(SelectableText(e.date!.toStringFormattedGetOperationHistory())),
                                            if (settingsState.auditItems.contains(AuditSort.action))
                                            DataCell(SelectableText(e.actionName ?? 'Неизвестно')),
                                            if (settingsState.auditItems.contains(AuditSort.application))
                                            DataCell(SelectableText(e.application ?? 'Неизвестно')),
                                            if (settingsState.auditItems.contains(AuditSort.clientLogin))
                                            DataCell(SelectableText(e.clientLogin ?? 'Неизвестно')),
                                            if (settingsState.auditItems.contains(AuditSort.clientName))
                                            DataCell(SelectableText(e.clientName ?? 'Неизвестно')),
                                            if (settingsState.auditItems.contains(AuditSort.supplierName))
                                            DataCell(SelectableText(e.supplierName ?? 'Неизвестно')),
                                            if (settingsState.auditItems.contains(AuditSort.description))
                                            DataCell(SelectableText(e.description ?? 'Неизвестно')),
                                          ]
                                        )).toList()
                                      )
                                    ),
                                    RowCounter(state.audit.length),
                                    BlocBuilder<AuditBloc, AuditState>(
                                      builder: (context, state) {
                                        Widget body = Container();
                                        if (state is AuditLoading) {
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
                                        } else if (state is AuditLoaded){
                                          if (state.isLoadMoreAvaiable) {
                                            body = Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ActionButton(
                                                  name: 'Загрузить еще',
                                                  widthSize: 170,
                                                  onTap: () => context.read<AuditBloc>().add(AuditLoadMore(state.audit.length)),
                                                )                                                
                                              ],
                                            );
                                          } else {
                                            body = state.audit.isNotEmpty ? Padding(
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
                                )
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
          )
        ],
      )
    )
  );

  void _onSortTap(
    AuditSort sort,
    bool sortAscending,
    int loadCount
  ) {
    context.read<AuditBloc>().add(AuditLoad(
      dateFrom: _dateFrom,
      dateTo: _dateTo,
      application: _selectedApplication,
      action: _selectedAction,
      supplierId: _selectedSupplier?.id,
      description: _descriptionController.text,
      sort: sort,
      sortAscending: sortAscending,
      loadCount: loadCount,
    ));
  }

  void _onSearchTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<AuditBloc>().add(AuditLoad(
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        application: _selectedApplication,
        action: _selectedAction,
        supplierId: _selectedSupplier?.id,
        description: _descriptionController.text,
      ));
    }
  }

  void _onLoadInfo() {
      context.read<AuditBloc>().add(AuditLoad(
        dateFrom: _dateFrom,
        dateTo: _dateTo,
        application: _selectedApplication,
        action: _selectedAction,
        supplierId: _selectedSupplier?.id,
        description: _descriptionController.text,
      ));
  }

  void _onRunExport() {
    if(_getIsAvialableAudit) {
      context.read<AuditBloc>().add(AuditExportRun());
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.getIsNotAvaliableAuditExport,
        type: DialogType.info
      );         
    }
  }  

  void _onRunAuditArchive()  {
    if(_archiveIsAvaliableAudit && _getIsAvialableAudit) {
      Navigation.toAuditArchive();
      context.read<AuditArchiveBloc>();
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.archiveIsNotAvaliable,
        type: DialogType.info
      );        
    }
  }
}