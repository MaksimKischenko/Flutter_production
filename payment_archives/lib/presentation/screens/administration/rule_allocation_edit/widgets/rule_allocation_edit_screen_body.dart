
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/routing/routes.gr.dart';
import 'package:payment_tracking_module/presentation/screens/screens.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';
import 'package:responsive_ui/responsive_ui.dart';

class RuleAllocationEditScreenBody extends StatefulWidget {

  const RuleAllocationEditScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<RuleAllocationEditScreenBody> createState() => _RuleAllocationEditScreenBodyState();
}

class _RuleAllocationEditScreenBodyState extends State<RuleAllocationEditScreenBody> {

  late ScrollController _scrollController;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _yearController;
  late TextEditingController _monthController;
  late TextEditingController _dayController;
  late RuleAllocationUpdateRequest _ruleAllocationUpdateBody; 
  RuleAllocationData? _ruleAllocationData;
  DataSource? _selectedDataSource;
  ArchiveLocation? _selectedArchiveLocation;


  bool get isSaveAvailable {
    if (_ruleAllocationData == null) return false;
    return _ruleAllocationData?.storeYear  != int.tryParse(_yearController.text)
    || _ruleAllocationData?.storeMonth  != int.tryParse(_monthController.text)
    || _ruleAllocationData?.storeDay  != int.tryParse(_dayController.text)
    || _ruleAllocationData?.sourceId != _selectedDataSource?.id
    || _ruleAllocationData?.locationId != _selectedArchiveLocation?.id
    || _ruleAllocationData?.isDefault != _ruleAllocationUpdateBody.isDefault;
  }

 @override
  void initState() {
    super.initState();
    _yearController = TextEditingController();
    _monthController = TextEditingController();
    _dayController = TextEditingController();
    _scrollController = ScrollController();
    _ruleAllocationUpdateBody = RuleAllocationUpdateRequest.empty();
    _formKey = GlobalKey<FormState>();    
    _yearController.addListener(() {
      if(_yearController.text.isEmpty) {
        _monthController.text = '';
        _dayController.text = '';
      }
    });
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => SafeArea(
      child: Column(
        children: [
           const ManagmentScreenTitle(
            title: RuleAllocationEditScreen.pageName 
          ),
          const Divider(),
          BlocConsumer<RuleAllocationUpdateBloc, RuleAllocationUpdateState>(
            listener: (context, state) {
              if(state is RuleAllocationUpdateNetworkError) {
                RequestUtil.catchNetworkError(
                  context: context,
                  obj: state.error
                );                
              } else if (state is RuleAllocationUpdateInitial) {
                _onInitialState(state);
              } else if (state is RuleAllocationUpdateSuccess) {
                _onPopWithArgs(state.ruleAllocationData);
              }
            },
            builder: (context, state) {
              Widget body = const SizedBox();
              if(state is RuleAllocationUpdateLoading) {
                body = const Expanded(
                  child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                );
              } else if (state is RuleAllocationUpdateInitial) {
                body = Expanded(
                  child: RawScrollbar(
                    thumbColor: AppStyles.colorGrey2,                   
                    thumbVisibility: true,
                    interactive: true,
                    controller: _scrollController,              
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),   
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 1000
                            ),   
                            child: Form(
                              key: _formKey,
                              child: Responsive(
                                runSpacing: 16,
                                children: [                                 
                                    Div(
                                      divison: const Division(
                                        colL: 4,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: InputField(
                                          maxLength: 4,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                            LengthLimitingTextInputFormatter(4)                                            
                                          ],
                                          controller: _yearController,
                                          mandatory: true,
                                          labelText: RuleAllocationActionFieldNames.year.message,
                                          onSaved: (value) {
                                            if (_ruleAllocationData?.storeYear.toString() != value) {
                                              _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(
                                                storeYear: int.tryParse(value)
                                              );
                                            } else {
                                              _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(
                                                storeYear: null
                                              );
                                            }                                           
                                          },
                                          onChanged: (value) => setState(() {})
                                        ))
                                    ),
                                    Div(
                                    divison: const Division(
                                      colL: 4,
                                      colM: 12,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: InputField(
                                        maxLength: 2,
                                        isReadOnly: _yearController.text.isEmpty,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'^(0?[1-9]|1[0-2])$')),
                                          LengthLimitingTextInputFormatter(2)                                               
                                        ],
                                        controller: _monthController,
                                        mandatory: false,
                                        labelText: RuleAllocationActionFieldNames.month.message,
                                        onSaved: (value) {
                                          if (_ruleAllocationData?.storeMonth.toString() != value) {
                                            _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(
                                              storeMonth: int.tryParse(value)
                                            );
                                          } else {
                                            _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(
                                              storeMonth: null
                                            );
                                          }                                           
                                        },
                                        onChanged: (value) => setState(() {}),
                                        validator: (value) {
                                          if(value.isNotEmpty) {
                                            final monthPeriod = int.parse(value);
                                            if (monthPeriod > 12 || monthPeriod < 1) {
                                              return 'Неверный формат месяца';
                                            }
                                            return null;      
                                          }
                                          return null;                                  
                                        },
                                      ))
                                    ), 
                                    Div(
                                    divison: const Division(
                                      colL: 4,
                                      colM: 12,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: InputField(
                                        maxLength: 2,
                                        mandatory: false,
                                        isReadOnly: _yearController.text.isEmpty || _monthController.text.isEmpty,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'^(0?[1-9]|[12][0-9]|3[01])$')),
                                          LengthLimitingTextInputFormatter(2)                                             
                                        ],
                                        controller: _dayController,
                                        labelText: RuleAllocationActionFieldNames.day.message,
                                        onSaved: (value) {
                                          if (_ruleAllocationData?.storeDay.toString() != value) {
                                            _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(
                                              storeDay: int.tryParse(value)
                                            );
                                          } else {
                                            _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(
                                              storeDay: null
                                            );
                                          }                                           
                                        },                                         
                                      ))
                                    ),
                                    Div(
                                      divison: const Division(
                                        colL: 6,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: DropDown<DataSource>(
                                            title: RuleAllocationActionFieldNames.source.message,       
                                            items: state.dataSources,
                                            selected: _selectedDataSource,
                                            itemBuilder: (item) => item.caption ?? '',   
                                            onTap: (item) => setState(() => _selectedDataSource = item),  
                                            onSaved: (value) => _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(sourceId: value?.id ?? 0),
                                            validator: () {
                                              if (_selectedDataSource == null) {
                                                return 'Выберите источник данных';
                                              }
                                              return null;
                                            },                                                                                                          
                                          ),
                                      )
                                    ),
                                    Div(
                                      divison: const Division(
                                        colL: 6,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: DropDown<ArchiveLocation>(
                                            mandatory: true,
                                            title: RuleAllocationActionFieldNames.loction.message,       
                                            items: state.archiveLocations,
                                            selected: _selectedArchiveLocation,
                                            itemBuilder: (item) => item.caption ?? '',   
                                            onTap: (item) => setState(() => _selectedArchiveLocation = item),  
                                            onSaved: (value) => _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(locationId: value?.id ?? 0),
                                            validator: () {
                                              if (_selectedArchiveLocation == null) {
                                                return 'Выберите приемник данных';
                                              }
                                              return null;
                                            },                                                                                                          
                                          ),
                                      )
                                    ),                                       
                                    Div(
                                      divison: const Division(
                                        colL: 12,
                                        colM: 12,                  
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: StatusSwitcher(
                                          value: _ruleAllocationUpdateBody.isDefault ?? false,
                                          text: RuleAllocationActionFieldNames.isDefault.message,
                                          onChanged: (value) => setState(() {
                                            _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(
                                            isDefault : value
                                           );
                                          }),                               
                                        )
                                      )
                                    ),                                                                                                                                                                            
                                ],
                              ),
                            ),                   
                          ),
                        ),              
                      ),
                    ),
                  )
                );
              }
              return body;
            },
          ),
          const Divider(),         
          Padding(
            padding: const EdgeInsets.all(40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SubmitButton(
                  isActive: isSaveAvailable,
                  name: ButtonNames.save.message,
                  onTap: _onSaveTap,
                ),
                const SizedBox(width: 10),
                SubmitButton(
                  name: ButtonNames.cancel.message,
                  onTap: _onBackTap,
                )
              ],
            ),
          ),                         
        ],
      ),
    );

  void _onInitialState(RuleAllocationUpdateInitial state) {
    _ruleAllocationData = state.ruleAllocationData;
    _selectedDataSource = state.dataSources.firstWhere((element) => element.id == _ruleAllocationData?.sourceId, orElse: () =>  DataSource(id: state.ruleAllocationData?.id ?? 0));
    _selectedArchiveLocation = state.archiveLocations.firstWhere((element) => element.id == _ruleAllocationData?.locationId, orElse: () => ArchiveLocation(id: state.ruleAllocationData?.locationId ?? 0));
    _yearController.text = state.ruleAllocationData?.storeYear.toString() ?? '';
    _monthController.text = state.ruleAllocationData?.storeMonth?.toString() ?? '';
    _dayController.text = state.ruleAllocationData?.storeDay?.toString() ?? '';
    _ruleAllocationUpdateBody = _ruleAllocationUpdateBody.copyWith(isDefault: state.ruleAllocationData?.isDefault ?? false);    
  }
 
  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<RuleAllocationUpdateBloc>().add(RuleAllocationUpdateRun(_ruleAllocationUpdateBody));
    }
  }  

  void _onBackTap() {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pushAndPopUntil(const RuleAlloctionsRoute(), predicate: (route) => false);
    }
  }   

  void _onPopWithArgs(RuleAllocationData? args) {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop<RuleAllocationData>(args);
    } else {
      AutoRouter.of(context).popAndPush(const RuleAlloctionsRoute(),result: args);
    }    
  }       
}