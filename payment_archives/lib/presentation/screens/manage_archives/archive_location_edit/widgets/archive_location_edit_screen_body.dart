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

class ArchiveLocationEditScreenBody extends StatefulWidget {

  const ArchiveLocationEditScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  State<ArchiveLocationEditScreenBody> createState() => _ArchiveLocationEditScreenBodyState();
}

class _ArchiveLocationEditScreenBodyState extends State<ArchiveLocationEditScreenBody> {

  late ScrollController _scrollController; 
  late GlobalKey<FormState> _formKey;
  late TextEditingController _captionController;
  late TextEditingController _hostController;
  late TextEditingController _passwordController;
  late TextEditingController _portController;
  late TextEditingController _nameBDController;
  late ArchiveLocationUpdateRequest _archiveLocationUpdateBody;  

  ArchiveLocation? _archiveLocation;

  bool get isSaveAvailable {
    if (_archiveLocation == null) return false;
    return _archiveLocation?.caption  != _captionController.text
    || _archiveLocation?.connectionHost  != _hostController.text
    || _archiveLocation?.connectionPort  != int.tryParse(_portController.text)
    || _archiveLocation?.password != _passwordController.text 
    || _archiveLocation?.databaseName  != _nameBDController.text
    || _archiveLocation?.enabled != _archiveLocationUpdateBody.enabled;
  }

 @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _formKey = GlobalKey<FormState>();
    _captionController = TextEditingController();
    _hostController = TextEditingController();
    _portController = TextEditingController();
    _nameBDController = TextEditingController();
    _passwordController = TextEditingController();
    _archiveLocationUpdateBody = ArchiveLocationUpdateRequest.empty();
  }

  @override
  void dispose() {
    _captionController.dispose();
    _hostController.dispose();
    _portController.dispose();
    _nameBDController.dispose();
    _scrollController.dispose(); 
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
      child: Column(
        children: [
           const ManagmentScreenTitle(
            title: ArchiveLocationEditScreen.pageName 
          ),
          const Divider(),
          BlocConsumer<ArchiveLocationUpdateBloc, ArchiveLocationUpdateState>(
            listener: (context, state) {
              if(state is ArchiveLocationUpdateNetworkError) {
                RequestUtil.catchNetworkError(
                  context: context,
                  obj: state.error
                );                
              } else if (state is ArchiveLocationUpdateInitial) {
                _onInitialState(state);
              } else if (state is ArchiveLocationUpdateSuccess) {
                _onPopWithArgs(state.archiveLocation);
              }
            },
            builder: (context, state) {
              Widget body = const SizedBox();
              if(state is ArchiveLocationUpdateLoading) {
                body = const Expanded(
                  child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                );
              } else if (state is ArchiveLocationUpdateInitial) {
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
                                        maxLength: 10,
                                        labelText: ArchiveLocationActionFieldNames.date.message,
                                        initialValue: _archiveLocation?.createDate?.toStringFormatted()
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
                                        maxLength: 255,
                                        labelText: ArchiveLocationActionFieldNames.name.message,
                                        initialValue: _archiveLocation?.connectionUser
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
                                        maxLines: 10,
                                        maxLength: 255,
                                        controller: _captionController,
                                        labelText: ArchiveLocationActionFieldNames.caption.message,
                                        onSaved: (value) {
                                          if (_archiveLocation?.caption != value) {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              caption: value
                                            );
                                          } else {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              caption: null
                                            );
                                          }                                           
                                        },
                                       onChanged: (value) => setState(() {})
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
                                        maxLength: 255,
                                        controller: _hostController,
                                        labelText: ArchiveLocationActionFieldNames.host.message,
                                        onSaved: (value) {
                                          if (_archiveLocation?.connectionHost != value) {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              connectionHost: value
                                            );
                                          } else {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              connectionHost: null
                                            );
                                          }                                           
                                        }, 
                                        onChanged: (value) => setState(() {})                                       
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
                                        mandatory: true,
                                        maxLength: 255,
                                        controller: _portController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                          LengthLimitingTextInputFormatter(4)                                          
                                        ],                                        
                                        labelText: ArchiveLocationActionFieldNames.port.message,  
                                        onSaved: (value) {
                                          if (_archiveLocation?.connectionPort.toString() != value) {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              connectionPort: int.tryParse(value)
                                            );
                                          } else {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              connectionPort: null
                                            );
                                          }                                           
                                        }, 
                                        onChanged: (value) => setState(() {})                                                                               
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
                                        maxLength: 255,
                                        controller: _nameBDController,
                                        labelText: ArchiveLocationActionFieldNames.nameBD.message,
                                        onSaved: (value) {
                                          if (_archiveLocation?.databaseName != value) {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              databaseName: value
                                            );
                                          } else {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              databaseName: null
                                            );
                                          }                                           
                                        },  
                                        onChanged: (value) => setState(() {})                                          
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
                                        controller: _passwordController,
                                        labelText: DataSourceActionFieldNames.password.message,
                                        onSaved: (value) {
                                          if (_archiveLocation?.password != value) {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              connectionPassword: value
                                            );
                                          } else {
                                            _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                              connectionPassword: null
                                            );
                                          }                                           
                                        },
                                        onChanged: (value) => setState(() {}),                                           
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
                                      child: StatusSwitcher(
                                        value: _archiveLocationUpdateBody.enabled ?? false,
                                        text: ArchiveLocationActionFieldNames.enable.message,
                                        onChanged: (value) => setState(() {
                                          _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(
                                          enabled : value
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

  void _onInitialState(ArchiveLocationUpdateInitial state) {
    _archiveLocation = state.archiveLocation;
    _archiveLocationUpdateBody = _archiveLocationUpdateBody.copyWith(enabled: state.archiveLocation?.enabled ?? false);
    _captionController.text = state.archiveLocation?.caption?? '';
    _hostController.text = state.archiveLocation?.connectionHost ?? '';
    _passwordController.text = state.archiveLocation?.password ?? '';
    _portController.text =  state.archiveLocation?.connectionPort.toString() ?? '';
    _nameBDController.text = state.archiveLocation?.databaseName ?? '';    
  }

  void _onSaveTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<ArchiveLocationUpdateBloc>().add(ArchiveLocationUpdateRun(_archiveLocationUpdateBody));
    }
  }  

  void _onBackTap() {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pushAndPopUntil(const ArchiveLocationRoute(), predicate: (route) => false);
    }
  }   

  void _onPopWithArgs(ArchiveLocation? args) {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop<ArchiveLocation>(args);
    } else {
      AutoRouter.of(context).popAndPush(const ArchiveLocationRoute(),result: args);
    }  
  }
}