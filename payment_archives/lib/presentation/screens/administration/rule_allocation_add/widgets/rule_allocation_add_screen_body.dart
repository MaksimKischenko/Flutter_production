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

class RuleAllocationsAddScreenBody extends StatefulWidget {
  const RuleAllocationsAddScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<RuleAllocationsAddScreenBody> createState() => _RuleAllocationsAddScreenBodyState();
}

class _RuleAllocationsAddScreenBodyState extends State<RuleAllocationsAddScreenBody> {
  late ScrollController _scrollController;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _yearController;
  late TextEditingController _monthController;
  late TextEditingController _dayController;
  late RuleAllocationInsertRequest _ruleAllocationInsertBody;
  DataSource? _selectedDataSource;
  ArchiveLocation? _selectedArchiveLocation;


 @override
  void initState() {
    super.initState();
    _yearController = TextEditingController();
    _monthController = TextEditingController();
    _dayController = TextEditingController();
    _scrollController = ScrollController();
    _ruleAllocationInsertBody = RuleAllocationInsertRequest.empty();
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
            const ManagmentScreenTitle(title: RuleAllocationAddScreen.pageName),
            const Divider(),
            BlocConsumer<RuleAllocationInsertBloc, RuleAllocationInsertState>(
              listener: (context, state) {
                if (state is RuleAllocationInsertNetworkError) {
                  RequestUtil.catchNetworkError(context: context, obj: state.error);
                } else if (state is RuleAllocationInsertSuccess) {
                  if(AutoRouter.of(context).canPop()) {
                    AutoRouter.of(context).pop<RuleAllocationData>(state.ruleAllocationdata);
                  } 
                } 
              },
              builder: (context, state) {
                Widget body  = const SizedBox();
                if(state is RuleAllocationInsertLoading) {
                  body = const Expanded(
                    child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                  );                  
                } else if (state is RuleAllocationInsertInitial) {
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
                                maxWidth: 1000,
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
                                          onSaved: (value) => _ruleAllocationInsertBody = _ruleAllocationInsertBody.copyWith(storeYear: int.tryParse(value)),
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
                                        labelText: RuleAllocationActionFieldNames.month.message,
                                        onSaved: (value) => _ruleAllocationInsertBody = _ruleAllocationInsertBody.copyWith(storeMonth: int.tryParse(value)),
                                        onChanged: (value) => setState(() {}),
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
                                        isReadOnly: _yearController.text.isEmpty || _monthController.text.isEmpty,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp(r'^(0?[1-9]|[12][0-9]|3[01])$')),
                                          LengthLimitingTextInputFormatter(2)                                                
                                        ],
                                        controller: _dayController,
                                        labelText: RuleAllocationActionFieldNames.day.message,
                                        onSaved: (value) => _ruleAllocationInsertBody = _ruleAllocationInsertBody.copyWith(storeDay: int.tryParse(value)),                                          
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
                                            mandatory: true,
                                            title: RuleAllocationActionFieldNames.source.message,       
                                            items: state.dataSources,
                                            selected: _selectedDataSource,
                                            itemBuilder: (item) => item.caption ?? '',   
                                            onTap: (item) => setState(() => _selectedDataSource = item),  
                                            onSaved: (value) => _ruleAllocationInsertBody = _ruleAllocationInsertBody.copyWith(sourceId: value?.id ?? 0),
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
                                            onSaved: (value) => _ruleAllocationInsertBody = _ruleAllocationInsertBody.copyWith(locationId: value?.id ?? 0),
                                            validator: () {
                                              if (_selectedDataSource == null) {
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
                                          value: _ruleAllocationInsertBody.isDefault ?? false,
                                          text: RuleAllocationActionFieldNames.isDefault.message,
                                          onChanged: (value) {
                                            _ruleAllocationInsertBody = _ruleAllocationInsertBody.copyWith(
                                              isDefault : value
                                            );
                                          }
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
                    ));
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
          ]         
        ),
      );

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<RuleAllocationInsertBloc>().add(RuleAllocationInsertRun(_ruleAllocationInsertBody));
    }
  }  

  void _onBackTap() {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pushAndPopUntil(const RuleAlloctionsRoute(), predicate: (route) => false);
    }
  }   
}
