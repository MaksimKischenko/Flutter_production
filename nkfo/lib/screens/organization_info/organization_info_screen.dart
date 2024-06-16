import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
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

class OrganizationInfoScreen extends StatefulWidget {
  static const pageName = 'Организации.Общая информация';

  @override
  _OrganizationInfoState createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationInfoScreen> {

  final List<String> _pages = [
    'Общая информация',
    'Услуги'
  ];

  int _selectedPage = 0;
  bool _editIsAvialableSupplier = true;
  bool _deleteIsAvialableSupplier = true;
  bool _getIsAvialableService = true;
  bool _addIsAvialableService = true;
  bool _editIsAvialableService = true;
  bool _deleteIsAvialableService = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SupplierBloc, SupplierState>(
            buildWhen: (_, next) => next is SupplierInitial,
            builder: (context, state) {
              String? organizationName;
              Color? statusColor;
              String? statusName;
              List<Widget>? actions;
              if (state is SupplierInitial) {
                _editIsAvialableSupplier = state.patchIsAvaiableSupplier;
                _deleteIsAvialableSupplier = state.deleteIsAvaliableSupplier;
                _addIsAvialableService = state.postIsAvaliableService;
                organizationName = state.supplier.shortName;
                statusColor = state.supplier.statusColor;
                statusName = state.supplier.statusText;
                actions = [
                  DeleteOrganizationButton(
                    onTap: _onDeleteTap   
                  ),
                  const SizedBox(width: 16),
                  EditButton(
                    onTap: () => _onEditTap(state.supplier)
                  ),
                  const SizedBox(width: 16),
                  AddServiceButton(
                    onTap: () => _onAddServiceTap(state.supplier.id)
                  ),
                ];
              }
              return CommonAppBar(
                title: 'Просмотр организации',
                organizationName: organizationName,
                statusColor: statusColor,
                statusName: statusName,
                actions: actions,
              );
            },
          ),
          const Divider(),
          Expanded(
            child: BlocConsumer<SupplierBloc, SupplierState>(
              listener: (context, state) {
                if (state is SupplierDeleteSuccess) {
                  context.read<SuppliersBloc>().add(SuppliersDeleteSupplier(state.supplier));
                  Navigator.of(context).pop();
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Организация удалена',
                    type: DialogType.success
                  );
                } else if (state is SupplierServiceDeleteSuccess) {
                  Multiplatform.showMessage(
                    context: context,
                    title: 'Успешно',
                    message: 'Услуга id:${state.service.id} удалена',
                    type: DialogType.success
                  );
                } else if (state is SupplierError) {
                  RequestUtil.catchNetworkError(context: context, obj: state.error);
                }
              },
              builder: (context, state) {
                Widget body = Container();
                if (state is SupplierInitError) {
                  body = Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: double.maxFinite),
                      const Text('Невозможно просмотреть организацию'),
                      const SizedBox(height: 8),
                      CupertinoButton(
                        onPressed: () => context
                            .read<SupplierBloc>()
                            .add(SupplierInit()),
                        child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                      )
                    ],
                  );
                } else if (state is SupplierLoading) {
                  body = const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: double.maxFinite),
                      LoadingIndicator()
                    ],
                  );
                } else if (state is SupplierInitial) {

                  _editIsAvialableService = state.patchIsAvaliableService;
                  _deleteIsAvialableService = state.deleteIsAvaliableService;
                  _getIsAvialableService = state.getIsAvailableService;

                  body = Padding(
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
                              onTap: () => setState(() {
                                _selectedPage = index;
                              } ),
                              selected: index == _selectedPage,
                            )).toList(),
                          ),
                        ),
                        const SizedBox(width: 32),
                        if (_selectedPage == 0)
                        Expanded(
                          child: SingleChildScrollView(
                            child: ResponsiveBuilder(
                              builder: (context, sizingInformation) {
                                var width = 800.0;
                                if (sizingInformation.isMobile || sizingInformation.isTablet) {
                                  width = sizingInformation.screenSize.width;
                                }
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: width,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(40),
                                        child: Responsive(
                                          runSpacing: 16,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            InfoItem(
                                              title: 'Код организации (ЕРИП)',
                                              subtitle: state.supplier.outSupplierCode
                                            ),
                                            InfoItem(
                                              title: 'Статус подключения',
                                              subtitle: state.supplier.statusText,
                                            ),
                                            InfoItem(
                                              title: 'Краткое наименование',
                                              subtitle: state.supplier.shortName
                                            ),
                                            InfoItem(
                                              title: 'УНП',
                                              subtitle: state.supplier.unp
                                            ),
                                            InfoItem(
                                              title: 'Полное наименование',
                                              subtitle: state.supplier.name
                                            ),
                                            InfoItem(
                                              title: 'Юридический адрес',
                                              subtitle: state.supplier.address
                                            ),
                                            InfoItem(
                                              title: 'E-mail',
                                              subtitle: state.supplier.email
                                            ),
                                            InfoItem(
                                              title: 'BIC банка',
                                              subtitle: state.supplier.bankBic
                                            ),
                                            InfoItem(
                                              title: 'Номер счета',
                                              subtitle: state.supplier.account
                                            ),
                                            InfoItem(
                                              title: 'Абонент',
                                              subtitle: state.supplier.abonent
                                            ),
                                            InfoItem(
                                              title: 'Номер договора',
                                              subtitle: state.supplier.contract
                                            ),
                                            InfoItem(
                                              title: 'Номер терминала',
                                              subtitle: state.supplier.terminalNumber
                                            ),
                                            InfoItem(
                                              title: 'ФИО руководителя',
                                              subtitle: state.supplier.managerName
                                            ),
                                            InfoItem(
                                              title: 'Должность руководителя',
                                              subtitle: state.supplier.managerPost
                                            ),
                                            InfoItem(
                                              title: 'Главный бухгалтер',
                                              subtitle: state.supplier.bookkeeperName
                                            ),
                                            const InfoCategory('Параметры подключения к FTP'),
                                            InfoItem(
                                              title: 'Хост',
                                              subtitle: state.supplier.ftpServer
                                            ),
                                            InfoItem(
                                              title: 'Порт',
                                              subtitle: state.supplier.ftpPort?.toString()
                                            ),
                                            InfoItem(
                                              title: 'Логин',
                                              subtitle: state.supplier.ftpLogin
                                            ),
                                            InfoItem(
                                              title: 'Пароль',
                                              subtitle: state.supplier.ftpPassword
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ),
                                );
                              }
                            ),
                          ),
                        ),
                        if (_selectedPage == 1)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 800
                                  ),
                                  child: _getIsAvialableService? Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: state.services.map((e) => ServiceItem(
                                      item: e,
                                      onEditTap: _onEditServiceTap,       
                                      onDeleteTap: _onDeleteServiceTap                                      
                                    )).toList(),
                                  ) : Container()
                                ),
                              ],
                            )
                          ),
                        )
                      ],
                    ),
                  );
                }
                return body;
              },
            ),
          ),
        ],
      ),
    )
  );

  Future<void> _onEditTap(Supplier supplier) async {
    if(_editIsAvialableSupplier) {
      final updatedSupplier = await Navigation.toOrganizationEdit(supplier);
      if (updatedSupplier != null) {
        context.read<SupplierBloc>().add(SupplierUpdate(updatedSupplier));
      }
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableSupplier,
        type: DialogType.info
      ); 
    }
  }

  void _onDeleteTap() {
    if(_deleteIsAvialableSupplier) {
      Multiplatform.showDecisionMessage(
        context: context,
        message: '',
        action: () => context.read<SupplierBloc>().add(SupplierDelete()),
        dialogTitle: 'Уверены, что хотите удалить организацию?',
        buttonTitle: 'Удалить',
        cancelButtonTitle: 'Нет'
      );
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.deleteIsNotAvaliableSupplier,
        type: DialogType.info
      ); 
    }
  }

  Future<void> _onAddServiceTap(int supplierId) async {
    if(_addIsAvialableService) {
      final newService = await Navigation.toServiceAdd(supplierId);
      if (newService != null) {
        context.read<SupplierBloc>().add(SupplierNewService(newService));
      }
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.postIsNotAvaliableSupplierAccount,
        type: DialogType.info
      ); 
    }
  }

  
  Future<void> _onEditServiceTap(SupplierAccount service) async {
    if(_editIsAvialableService) {
      final updatedService = await Navigation.toServiceEdit(
        service: service,
      );
      if (updatedService != null) {
        context.read<SupplierBloc>().add(SupplierUpdateService(updatedService));
      }
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.patchIsNotAvaliableSupplierAccount,
        type: DialogType.info
      ); 
    }
  }

  void _onDeleteServiceTap(SupplierAccount service) {
    if(_deleteIsAvialableService) {
      Multiplatform.showDecisionMessage(
        context: context,
        message: '',
        action: () => context.read<SupplierBloc>().add(SupplierDeleteService(service.id)),
        dialogTitle: 'Уверены, что хотите удалить услугу?',
        buttonTitle: 'Удалить',
        cancelButtonTitle: 'Нет'
      );
    } else {
      Multiplatform.showMessage(
        context: context,
        title: 'Операция отклонена',
        message: AppConfig.deleteIsNotAvaliableSupplierAccount,
        type: DialogType.info
      ); 
    }
  }
}