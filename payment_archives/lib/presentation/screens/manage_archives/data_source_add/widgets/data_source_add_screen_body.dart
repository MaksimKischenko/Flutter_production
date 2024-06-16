import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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

class DataSourceAddScreenBody extends StatefulWidget {

  @override
  State<DataSourceAddScreenBody> createState() => _DataSourceAddScreenBodyState();
}

class _DataSourceAddScreenBodyState extends State<DataSourceAddScreenBody> {
  late ScrollController _controller;
  late GlobalKey<FormState> _formKey;
  late DataSourceInsertRequest _dataSourceInsertBody;
  DataSourceScaleStatus? _selectedScaleStatus = DataSourceScaleStatus.day;

 @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _formKey = GlobalKey<FormState>();
    _dataSourceInsertBody = DataSourceInsertRequest.empty();
  }

 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          children: [
            const ManagmentScreenTitle(title: DataSourceAddScreen.pageName),
            const Divider(),
            BlocConsumer<DataSourceInsertBloc, DataSourceInsertState>(
              listener: (context, state) {
                if (state is DataSourceInsertNetworkError) {
                  RequestUtil.catchNetworkError(context: context, obj: state.error);
                } else if (state is DataSourceInsertSuccess) {
                  if(AutoRouter.of(context).canPop()) {
                    AutoRouter.of(context).pop<DataSource>(state.dataSource);
                  } 
                } 
              },
              builder: (context, state) {
                Widget body  = const SizedBox();
                if(state is DataSourceInsertLoading) {
                  body = const Expanded(
                    child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                  );                  
                } else if (state is DataSourceInsertInitial) {
                  body = Expanded(
                    child: RawScrollbar(
                      thumbColor: AppStyles.colorGrey2,                      
                      thumbVisibility: true,
                      interactive: true,
                      controller: _controller,
                      child: SingleChildScrollView(
                        controller: _controller,
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
                                        colL: 6,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: InputField(
                                          isReadOnly: true,
                                          labelText: DataSourceActionFieldNames.date.message,
                                          initialValue: DateTime.now().toStringFormatted(),
                                          onSaved: (value) => _dataSourceInsertBody = 
                                          _dataSourceInsertBody.copyWith(createDate: DateTime.now()),                                          
                                        ))
                                    ),
                                    Div(
                                      divison: const Division(
                                        colL: 6,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: InputField(
                                          maxLength: 255,
                                          mandatory: true,
                                          labelText: DataSourceActionFieldNames.login.message,
                                          onSaved: (value) => _dataSourceInsertBody = _dataSourceInsertBody.copyWith(login: value),
                                        ))
                                    ),
                                    Div(
                                      divison: const Division(
                                        colL: 6,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: PasswordInputField(
                                          labelText: DataSourceActionFieldNames.password.message,
                                          onSaved: (value) => _dataSourceInsertBody = _dataSourceInsertBody.copyWith(password: value),      
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Введите пароль';
                                            }
                                            if (value.length < 6) {
                                              return 'Минимальная длина пароля ${6} символов';
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
                                        child: InputField(
                                          maxLength: 255,
                                          maxLines: 10,
                                          mandatory: true,
                                          labelText: DataSourceActionFieldNames.caption.message,
                                          onSaved: (value) => _dataSourceInsertBody = _dataSourceInsertBody.copyWith(caption: value),                                          
                                        ))
                                    ),   
                                    Div(
                                      divison: const Division(
                                        colL: 6,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: DropDown<DataSourceScaleStatus>(
                                            mandatory: true,
                                            title: DataSourceActionFieldNames.dataScale.message,       
                                            items: DataSourceScaleStatus.values,
                                            selected: _selectedScaleStatus,
                                            itemBuilder: (item) => item.message,   
                                            onTap: (item) => setState(() => _selectedScaleStatus = item),  
                                            onSaved: (value) => _dataSourceInsertBody = _dataSourceInsertBody.copyWith(dataScale: value?.dataScale ?? 0),
                                            validator: () {
                                            if (_selectedScaleStatus == null) {
                                              return 'Выберите масштаб данных';
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
                                          value: _dataSourceInsertBody.enabled ?? false,
                                          text: DataSourceActionFieldNames.enable.message,
                                          onChanged: (value) => _dataSourceInsertBody = _dataSourceInsertBody.copyWith(enabled: value)    
                                      ))
                                    ),  
                                    Div(
                                      divison: const Division(
                                        colL: 12,
                                        colM: 12,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: StatusSwitcher(
                                          value: _dataSourceInsertBody.blocked ?? false,
                                          text: DataSourceActionFieldNames.blocked.message,
                                          onChanged: (value) => _dataSourceInsertBody = _dataSourceInsertBody.copyWith(blocked: value)    
                                      ))
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
      context.read<DataSourceInsertBloc>().add(DataSourceInsertRun(_dataSourceInsertBody));
    }
  }  

  void _onBackTap() {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pushAndPopUntil(const DataSourceDirectoryRoute(), predicate: (route) => false);
    }
  }   
}
