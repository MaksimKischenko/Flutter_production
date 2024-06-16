import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/date_helper.dart';
import 'package:responsive_ui/responsive_ui.dart';

class PaymentsFiltersScreen extends StatefulWidget {
  const PaymentsFiltersScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentsFiltersScreenState createState() => _PaymentsFiltersScreenState();
}

class _PaymentsFiltersScreenState extends State<PaymentsFiltersScreen> with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = SearchPaymentMethod.values.map<Tab>((e) => Tab(text: e.name)).toList();
  late TabController _tabController;
  late SearchPaymentData requestData;
  final _formKey = GlobalKey<FormState>();
  PaymentMethodModel _selectedPaymentMethod = PaymentMethodModel.all;
  SearchPaymentMethod _selectedSearchPaymentMethod = SearchPaymentMethod.full;

  DateTime _dateFrom = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _dateTo = DateTime.now();
  DateTime _timeFrom = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  DateTime _timeTo = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59);
  double _sumMin = 0;
  double _sumMax = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    requestData = SearchPaymentData.empty();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DialogWrapper(
      title: 'Отбор платежей по критериям',
      buttonTitle: 'Начать поиск',
      onApplyPressed: _onApplyTap,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
            child: TabBar(
              controller: _tabController,
              onTap: _onTabTap,
              isScrollable: true,
              tabs: _tabs,
              indicatorColor: AppStyles.colorGold,
              indicatorWeight: 2,
              labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppStyles.mainColor),
              labelColor: AppStyles.mainColor,
              overlayColor: MaterialStateProperty.all(const Color(0xffEDF6FF)),
              unselectedLabelColor: AppStyles.mainTextColor),
          ),
          //const SizedBox(height: 12),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: Form(
              key: _formKey,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [buildFullSearch(), buildIdsSearch(), buildNamesSearch()]
              ),
            ),
          )
        ],
      ));

  Widget buildIdsSearch() => BlocBuilder<SearchPaymentBloc, SearchPaymentState>(
    builder: (context, state) {
      if (state is SearchPaymentActualInfo) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: InputField(
              initialValue: state.requestData.ids?.toString().replaceAll(RegExp(r'[\[\]]'), '') ?? '',              
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[,0-9]'))],
              maxLines: 1000,
              minLines: 50,
              mandatory: true,
              labelText: 'ID платежей ЕРИП',
              onSaved: (value) {
                final resultList = value.split(',');
                _onIdListSort(resultList);
                requestData = requestData.copyWith(ids: resultList);
              },
            ),
          ),
        );
      }  
      return const SizedBox.shrink();              
    },
  );

  Widget buildNamesSearch() => BlocBuilder<SearchPaymentBloc, SearchPaymentState>(
    builder: (context, state) {
      if (state is SearchPaymentActualInfo) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: InputField(
              initialValue: state.requestData.names?.toString().replaceAll(RegExp(r'[\[\]]'), '') ?? '',
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\sА-Яа-яA-Za-z0-9,]+'))],
              maxLines: 1000,
              minLines: 50,
              mandatory: true,
              labelText: 'ФИО плательщиков',
              onSaved: (value) {
                final resultList = value.replaceAll('\n', '').split(',');
                _onFullNameListSort(resultList);
                requestData = requestData.copyWith(names: resultList);
              },
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    },
  );

  Widget buildFullSearch() => BlocBuilder<SearchPaymentBloc, SearchPaymentState>(
        builder: (context, state) {
          if (state is SearchPaymentActualInfo) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Responsive(runSpacing: 16, children: [
                  Div(
                    divison: const Division(colL: 6, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: DatePicker(
                              mandatory: true,
                              initialDate: state.requestData.dateFrom,
                              labelText: PaymentActionFieldNames.fromTime.message,
                              onChange: (value) => _dateFrom = value ?? DateTime.now(),
                              validator: () {
                                if (_dateFrom.isAfter(_dateTo)) {
                                  return 'Некорректный промежуток времени';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          TimePicker(
                            initialValue: _timeFrom.toStringFormattedHoursOnly(),
                            labelText: AuditLogActionFieldNames.timeFrom.message,
                            onChanged: (value) => _timeFrom = value,
                          )
                        ],
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 6, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: DatePicker(
                              mandatory: true,
                              initialDate: state.requestData.dateTo,
                              labelText: PaymentActionFieldNames.toTime.message,
                              onChange: (value) => _dateTo = value ?? DateTime.now(),
                              validator: () {
                                if (_dateTo.isBefore(_dateFrom)) {
                                  return 'Некорректный промежуток времени';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          TimePicker(
                            initialValue: _timeTo.toStringFormattedHoursOnly(),
                            labelText: AuditLogActionFieldNames.timeTo.message,
                            onChanged: (value) => _timeTo = value,
                          )
                        ],
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 2, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          LengthLimitingTextInputFormatter(15)
                        ],
                        initialValue: state.requestData.paymentId?.toString() ?? '',
                        maxLength: 15,
                        labelText: PaymentActionFieldNames.paymentId.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(paymentId: Wrapped.value(int.tryParse(value)));
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 4, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.payerName,
                        maxLength: 255,
                        labelText: PaymentActionFieldNames.fio.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(payerName: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.payerIn,
                        maxLength: 15,
                        labelText: PaymentActionFieldNames.passportIn.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(payerIn: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.payerDoc,
                        maxLength: 9,
                        labelText: PaymentActionFieldNames.passport.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(payerDoc: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.payerAddress,
                        maxLength: 255,
                        labelText: PaymentActionFieldNames.address.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(payerAddress: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.payerAccount,
                        maxLength: 255,
                        labelText: PaymentActionFieldNames.account.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(payerAccount: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.supplierName,
                        maxLength: 99,
                        labelText: PaymentActionFieldNames.nameSuppplier.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(supplierName: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.supplierAccount,
                        maxLength: 28,
                        labelText: PaymentActionFieldNames.accountNumber.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(supplierAccount: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.bik,
                        maxLength: 11,
                        labelText: PaymentActionFieldNames.bik.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(bik: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.supplierUnp,
                        maxLength: 9,
                        labelText: PaymentActionFieldNames.unpSupplier.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(supplierUnp: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.budgetCode?.toString() ?? '',
                        maxLength: 5,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d{0,5}$'))],
                        labelText: PaymentActionFieldNames.code.message,
                        onChanged: (value) {
                          requestData = requestData.copyWith(budgetCode: Wrapped.value(int.tryParse(value ?? '')));
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.serviceName,
                        maxLength: 255,
                        labelText: PaymentActionFieldNames.serviceName.message,
                        onChanged: (value) {
                          requestData = requestData.copyWith(serviceName: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.paySumMin?.toString() ?? '',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?$')),
                        ],
                        maxLength: 255,
                        labelText: PaymentActionFieldNames.summMin.message,
                        onChanged: (value) {
                          requestData = requestData.copyWith(paySumMin: Wrapped.value(double.tryParse(value ?? '')));
                          _sumMin = double.tryParse(value ?? '') ?? 0;
                        },
                        validator: (value) {
                          if (_sumMin > _sumMax) {
                            return 'Неккоректная сумма';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.paySumMax?.toString() ?? '',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?$')),
                        ],
                        maxLength: 255,
                        labelText: PaymentActionFieldNames.summMax.message,
                        onChanged: (value) {
                          requestData = requestData.copyWith(paySumMax: Wrapped.value(double.tryParse(value ?? '')));
                          _sumMax = double.tryParse(value ?? '') ?? 0;
                        },
                        validator: (value) {
                          if (_sumMax < _sumMin) {
                            return 'Неккоректная сумма';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.receiptNo,
                        maxLength: 100,
                        labelText: PaymentActionFieldNames.receiptNo.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(receiptNo: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.systemPaymentId,
                        maxLength: 255,
                        labelText: PaymentActionFieldNames.operationNumber.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(systemPaymentId: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.terminalDept?.toString() ?? '',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          LengthLimitingTextInputFormatter(20)
                        ],
                        maxLength: 20,
                        labelText: PaymentActionFieldNames.branchNumber.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(terminalDept: Wrapped.value(int.tryParse(value)));
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InputField(
                        initialValue: state.requestData.terminalId,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^[@#$^&()a-zA-Z0-9]+$')),
                          LengthLimitingTextInputFormatter(20)
                        ],
                        maxLength: 20,
                        labelText: PaymentActionFieldNames.terminalCode.message,
                        onSaved: (value) {
                          requestData = requestData.copyWith(terminalId: value);
                        },
                      ),
                    ),
                  ),
                  Div(
                    divison: const Division(colL: 3, colM: 6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: DropDown<PaymentMethodModel>(
                        title: PaymentActionFieldNames.paymentMethod.message,
                        items: PaymentMethodModel.values,
                        height: 150,
                        selected: _selectedPaymentMethod,
                        itemBuilder: (item) => item.name,
                        onTap: (item) => setState(() => _selectedPaymentMethod = item),
                        onSaved: (value) => requestData = requestData.copyWith(paymentMethod: value),
                      ),
                    ),
                  ),
                ]),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );

  void _onApplyTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      switch (_selectedSearchPaymentMethod) {
        case SearchPaymentMethod.full:
          requestData = requestData.copyWith(
            searchPaymentMethod: _selectedSearchPaymentMethod,
            dateFrom:
                DateTime(_dateFrom.year, _dateFrom.month, _dateFrom.day, _timeFrom.hour, _timeFrom.minute).toLocal(),
            dateTo: DateTime(_dateTo.year, _dateTo.month, _dateTo.day, _timeTo.hour, _timeTo.minute).toLocal(),
          );
          break;
        case SearchPaymentMethod.ids:
          requestData = requestData.copyWith(
            searchPaymentMethod: _selectedSearchPaymentMethod,
          );
          break;
        case SearchPaymentMethod.names:
          requestData = requestData.copyWith(
            searchPaymentMethod: _selectedSearchPaymentMethod,
          );
          break;
      }
      AutoRouter.of(context).pop<SearchPaymentData>(requestData);
    }
  }

  void _onTabTap(int index) {
    requestData = SearchPaymentData.empty();
    switch (index) {
      case 0:
        _selectedSearchPaymentMethod = SearchPaymentMethod.full;
        break;
      case 1:
        _selectedSearchPaymentMethod = SearchPaymentMethod.ids;
        break;
      case 2:
        _selectedSearchPaymentMethod = SearchPaymentMethod.names;
        break;
    }
  }

  void _onIdListSort(List<String> idList) {
    idList.sort((a, b) {
      final aId = int.tryParse(a);
      final bId = int.tryParse(b);
      if (aId != null && bId != null) {
        return aId.compareTo(bId);
      } else {
        return a.compareTo(b);
      }
    });
  }

  void _onFullNameListSort(List<String> fullNameList) {
    fullNameList.sort((a, b) => a.compareTo(b));
  }
}
