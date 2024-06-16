import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_ui/responsive_ui.dart';

import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/widgets.dart';

class OrganizationsScreen extends StatefulWidget {
  static const pageName = 'Организации';

  @override
  _OrganizationsScreenState createState() => _OrganizationsScreenState();
}

class _OrganizationsScreenState extends State<OrganizationsScreen> {
  SupplierStatus _selectedStatus = SupplierStatus.all;

  final _unpController = TextEditingController();
  final _nameController = TextEditingController();

  SuppliersSort _sort = SuppliersSort.unp;

  final _supplierActions = <String>['Просмотреть'];
  String? emptyTableMessage;
  bool _addIsAvaliable = true;


  @override
  void initState() {
    super.initState();
    final currentAuthState = context.read<AuthBloc>().state;
    if (currentAuthState is AuthAuthorized) {
      context.read<SuppliersBloc>().add(const SuppliersInit());
    } 
    else {
      context.read<AuthBloc>().stream.listen((authState) {
        if (authState is AuthAuthorized) {
          context.read<SuppliersBloc>().add(const SuppliersInit());
        }
      });
    }
    //WidgetsBinding.instance.addPostFrameCallback((_) => _onSearchTap());
  }

  @override
  void dispose() {
    _unpController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CabinetMenu(
            selectedIndex: 0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Responsive(
              runSpacing: 16,
              children: [
                Div(
                  colL: 2,
                  colM: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFieldDropdownSearch<SupplierStatus>(
                      title: 'Статус',
                      showSearchBox: false,
                      maxHeight: 150,
                      items: SupplierStatus.values,
                      itemBuilder: (item) => item.name,
                      selected: _selectedStatus,
                      onTap: (item) => setState(() => _selectedStatus = item)
                    ),
                  ),
                ),
                Div(
                  colL: 2,
                  colM: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: UnpField(
                      controller: _unpController,
                    ),
                  ),
                ),
                Div(
                  colL: 2,
                  colM: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: NameField(
                      controller: _nameController,
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
                        SearchSuppliersButton(
                          onTap: _onSearchTap
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: ActionButton(
              onTap: _onAddSupplierTap
            ),
          ),
          const SizedBox(height: 24),
          BlocConsumer<SuppliersBloc, SuppliersState>(
            listener: (context, state) {
              if (state is SuppliersError) {
                if(!state.error.toString().contains('Http status error [401]')) {
                  RequestUtil.catchNetworkError(context: context, obj: state.error);
                }
              } else if (state is SuppliersGetNotAllow) {
                emptyTableMessage = state.message;
                _addIsAvaliable = false;       
              } 
            },
            buildWhen: (prev, next) {
              if (next is SuppliersError) return false;
              if (next is SuppliersLoading) return false;
              return true;
            },
            builder: (context, state) {
              var _organizations = <Supplier>[];
              var _isLoadMoreAvaiable = false;
              int? _sortColumnIndex;
              var _sortAscending = true;
              if (state is SuppliersLoaded) {
                _organizations = state.suppliers;
                _isLoadMoreAvaiable = state.isLoadMoreAvaiable;
                _sort = state.sort;
                _sortAscending = state.sortAscending;
                _addIsAvaliable = state.postIsAvaliable;
              } 
              return Expanded(
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, settingsState) {
                    if (settingsState is SettingsInitial) {
                      _sortColumnIndex = settingsState.supplierItems.indexOf(_sort);
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(
                              child: DataTable2(
                                sortColumnIndex: _sortColumnIndex,
                                sortAscending: _sortAscending,
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
                                    BlocBuilder<SuppliersBloc, SuppliersState>(
                                      builder: (context, state) {
                                        Widget emtyTableBody = Container();
                                        if(state is SuppliersLoading) {
                                          emtyTableBody = const LoadingIndicator(
                                            indicatorsSize: 80,
                                          );
                                        } else if(state is SuppliersGetNotAllow) {
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
                                  ...settingsState.supplierItems.map((e) => DataColumn2(
                                    label: Text(e.name),
                                    size: e.columnSize,
                                    onSort: (_, ascending) => _onSortTap(e, ascending, _organizations.length)
                                  )).toList(),
                                  DataColumn2(
                                    label: Container(),
                                    numeric: true,
                                    size: ColumnSize.S,
                                  ),
                                ],
                                rows: _organizations.map((e) => DataRow(
                                  //selected:true,
                                  cells: [
                                    if (settingsState.supplierItems.contains(SuppliersSort.unp))
                                    DataCell(SelectableText(e.unp ?? 'Неизвестно')),
                                    if (settingsState.supplierItems.contains(SuppliersSort.shortName))
                                    DataCell(SelectableText(e.shortName ?? 'Неизвестно')),
                                    if (settingsState.supplierItems.contains(SuppliersSort.outSupplierCode))
                                    DataCell(SelectableText(e.outSupplierCode ?? 'Неизвестно')),
                                    if (settingsState.supplierItems.contains(SuppliersSort.address))
                                    DataCell(SelectableText(e.address ?? 'Неизвестно')),
                                    if (settingsState.supplierItems.contains(SuppliersSort.bic))
                                    DataCell(SelectableText(e.bankBic ?? 'Неизвестно')),
                                    if (settingsState.supplierItems.contains(SuppliersSort.accountNumber))
                                    DataCell(SelectableText(e.account ?? '')),
                                    if (settingsState.supplierItems.contains(SuppliersSort.abonent))
                                    DataCell(SelectableText(e.abonent ?? 'Неизвестно')),
                                    if (settingsState.supplierItems.contains(SuppliersSort.contractNumber))
                                    DataCell(SelectableText(e.contract ?? 'Неизвестно')),
                                    if (settingsState.supplierItems.contains(SuppliersSort.status))
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
                                            e.statusText,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppStyles.mainColorDark
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )),
                                    DataCell(PopupMenuButton<int>(
                                      onSelected: (value) {
                                        if (value == 0) {
                                          Navigation.toOrganization(e);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => _supplierActions.mapIndexed((e, i) 
                                      => PopupMenuItem<int>(
                                        value: i,
                                        child: Text(e),
                                      )).toList(),
                                      child: const Icon(Icons.more_horiz_rounded, size: 16),
                                    )),
                                  ]
                                )).toList(),
                              ),
                            ),
                            RowCounter(_organizations.length),
                            BlocBuilder<SuppliersBloc, SuppliersState>(
                              builder: (context, state) {
                                Widget body = Container();
                                if (state is SuppliersLoading) {
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
                                } else {
                                  if (_isLoadMoreAvaiable) {
                                    body = Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ActionButton(
                                          name: 'Загрузить еще',
                                          widthSize: 170,
                                          onTap: () => context.read<SuppliersBloc>().add(SuppliersLoadMore(_organizations.length))
                                        )                                        
                                      ],
                                    );
                                  } else {
                                    body = _organizations.isNotEmpty ? Padding(
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
                ),
              );
            },
          ),
        ],
      ),
    ),
  );

  Future<void> _onAddSupplierTap() async {
    if(_addIsAvaliable) {
      final newSupplier = await Navigation.toOrganizationAdd();
      context.read<SuppliersBloc>().add(SuppliersNewSupplier(newSupplier!));
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.postIsNotAvaliableSupplier,
        type: DialogType.info
      );             
    }
  } 

  void _onSortTap(
    SuppliersSort sort,
    bool sortAscending,
    int loadCount
  ) {
    context.read<SuppliersBloc>().add(SuppliersInit(
      status: _selectedStatus,
      unp: _unpController.text,
      shortName: _nameController.text,
      sort: sort,
      sortAscending: sortAscending,
      loadCount: loadCount, 
    ));
  }

  void _onSearchTap() {
    context.read<SuppliersBloc>().add(SuppliersInit(
      status: _selectedStatus,
      unp: _unpController.text,
      shortName: _nameController.text,
    ));
  }
}