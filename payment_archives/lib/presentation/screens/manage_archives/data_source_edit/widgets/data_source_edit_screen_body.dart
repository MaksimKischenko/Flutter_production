
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

class DataSourceEditScreenBody extends StatefulWidget {

  const DataSourceEditScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<DataSourceEditScreenBody> createState() => _DataSourceEditScreenBodyState();
}

class _DataSourceEditScreenBodyState extends State<DataSourceEditScreenBody> {

  late ScrollController _scrollController;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _captionController;
  late TextEditingController _passwordController;
  late DataSourceUpdateRequest _dataSourceUpdateBody;
  DataSource? _dataSource;
  DataSourceScaleStatus? _selectedScaleStatus;

  bool get isSaveAvailable {
    if (_dataSource == null) return false;
    return _dataSource?.password != _passwordController.text
    || _dataSource?.caption != _captionController.text 
    || _dataSource?.dataScale != _selectedScaleStatus?.dataScale
    || _dataSource?.enabled != _dataSourceUpdateBody.enabled
    || _dataSource?.blocked != _dataSourceUpdateBody.blocked;
  }


 @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _formKey = GlobalKey<FormState>();
    _captionController = TextEditingController();
    _passwordController = TextEditingController();
    _dataSourceUpdateBody = DataSourceUpdateRequest.empty();
  }

  @override
  void dispose() {
    _captionController.dispose();
    _passwordController.dispose();
    _scrollController.dispose(); 
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => SafeArea(
      child: Column(
        children: [
           const ManagmentScreenTitle(
            title: DataSourceEditScreen.pageName 
          ),
          const Divider(),
          BlocConsumer<DataSourceUpdateBloc, DataSourceUpdateState>(
            listener: (context, state) {
              if(state is DataSourceUpdateNetworkError) {
                RequestUtil.catchNetworkError(
                  context: context,
                  obj: state.error
                );                
              } else if (state is DataSourceUpdateInitial) {
                _onInitialState(state);
              } else if (state is DataSourceUpdateSuccess) {
                _onPopWithArgs(state.dataSource);
              }
            },
            builder: (context, state) {
              Widget body = const SizedBox();
              if(state is DataSourceUpdateLoading) {
                body = const Expanded(
                  child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                );
              } else if (state is DataSourceUpdateInitial) {
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
                                      colL: 6,
                                      colM: 12,                  
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: InputField(                                       
                                        isReadOnly: true,
                                        labelText: DataSourceActionFieldNames.date.message,
                                        initialValue: _dataSource?.createDate?.toStringFormatted()
                                      )
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
                                        isReadOnly: true,
                                        labelText: DataSourceActionFieldNames.login.message,
                                        initialValue: _dataSource?.login
                                      )
                                    )
                                  ),                                      
                                  Div(
                                    divison: const Division(
                                      colL: 6,
                                      colM: 12,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: PasswordInputField(
                                        mandatory: false,
                                        controller: _passwordController,
                                        labelText: DataSourceActionFieldNames.password.message,
                                        onSaved: (value) {
                                          if (_dataSource?.password != value) {
                                            _dataSourceUpdateBody = _dataSourceUpdateBody.copyWith(
                                              password: value
                                            );
                                          } else {
                                            _dataSourceUpdateBody = _dataSourceUpdateBody.copyWith(
                                              password: null
                                            );
                                          }                                           
                                        },                                          
                                        onChanged: (_) => setState(() {}),                                                   
                                        validator: (value) {
                                          if (_passwordController.text.isNotEmpty && value.length < 6) {
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
                                        mandatory: true,
                                        maxLength: 255,
                                        maxLines: 10,                                        
                                        controller: _captionController,
                                        labelText: DataSourceActionFieldNames.caption.message,
                                        onSaved: (value) {
                                          if (_dataSource?.caption != value) {
                                            _dataSourceUpdateBody = _dataSourceUpdateBody.copyWith(
                                              caption: value
                                            );
                                          } else {
                                            _dataSourceUpdateBody = _dataSourceUpdateBody.copyWith(
                                              caption: null
                                            );
                                          }                                           
                                        },
                                        onChanged: (_) => setState(() {}),                                              
                                      )
                                    )
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
                                          onSaved: (value) => _dataSourceUpdateBody = _dataSourceUpdateBody.copyWith(dataScale: value?.dataScale ?? 0),
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
                                        value: _dataSourceUpdateBody.enabled ?? false,
                                        text: DataSourceActionFieldNames.enable.message,
                                        onChanged: (value) => setState(() {
                                          _dataSourceUpdateBody = _dataSourceUpdateBody.copyWith(
                                           enabled : value);
                                        })
                                      )
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
                                        value: _dataSourceUpdateBody.blocked ?? false,
                                        text: DataSourceActionFieldNames.blocked.message,
                                        onChanged: (value) => setState(() {
                                          _dataSourceUpdateBody = _dataSourceUpdateBody.copyWith(
                                           blocked : value);
                                        })
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


  void _onInitialState(DataSourceUpdateInitial state) {
    _dataSource = state.dataSource;
    _selectedScaleStatus = DataSourceScaleStatus.values.firstWhere((element) => element.dataScale == state.dataSource?.dataScale, orElse: () => DataSourceScaleStatus.day);
    _dataSourceUpdateBody = _dataSourceUpdateBody.copyWith(enabled: state.dataSource?.enabled ?? false);
    _dataSourceUpdateBody = _dataSourceUpdateBody.copyWith(blocked: state.dataSource?.blocked ?? false);
    _captionController.text = state.dataSource?.caption ?? '';
    _passwordController.text = state.dataSource?.password ?? '';
  }

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<DataSourceUpdateBloc>().add(DataSourceUpdateRun(_dataSourceUpdateBody));
    }
  }  

  void _onBackTap() {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pushAndPopUntil(const DataSourceDirectoryRoute(), predicate: (route) => false);
    }
  }   

  void _onPopWithArgs(DataSource? args) {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop<DataSource>(args);
    } else {
      AutoRouter.of(context).popAndPush(const DataSourceDirectoryRoute(),result: args);
    }    
  }
}