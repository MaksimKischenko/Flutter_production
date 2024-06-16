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



class ArchiveLocationAddScreenBody extends StatefulWidget {
  const ArchiveLocationAddScreenBody({super.key});

  @override
  State<ArchiveLocationAddScreenBody> createState() => _ArchiveLocationAddScreenBodyState();
}

class _ArchiveLocationAddScreenBodyState extends State<ArchiveLocationAddScreenBody> {

  late ScrollController _controller;
  late GlobalKey<FormState> _formKey;
  late ArchiveLocationInsertRequest _archiveLocationInsertBody; 

 @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _formKey = GlobalKey<FormState>();
    _archiveLocationInsertBody = ArchiveLocationInsertRequest.empty(); 
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
            const ManagmentScreenTitle(title: ArchiveLocationAddScreen.pageName),
            const Divider(),
            BlocConsumer<ArchiveLocationInsertBloc, ArchiveLocationInsertState>(
              listener: (context, state) {
                if (state is ArchiveLocationInsertNetworkError) {
                  RequestUtil.catchNetworkError(context: context, obj: state.error);
                } else if (state is ArchiveLocationInsertSuccess) {
                  if(AutoRouter.of(context).canPop()) {
                    AutoRouter.of(context).pop<ArchiveLocation>(state.archiveLocation);
                  } 
                } 
              },
              builder: (context, state) {
                Widget body  = const SizedBox();
                if(state is ArchiveLocationInsertLoading) {
                  body = const Expanded(
                    child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                  );                  
                } else if(state is ArchiveLocationInsertInitial) {
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
                                          maxLength: 10,
                                          labelText: ArchiveLocationActionFieldNames.date.message,
                                          initialValue: DateTime.now().toStringFormatted(),
                                          onSaved: (value) => _archiveLocationInsertBody = 
                                          _archiveLocationInsertBody.copyWith(createDate: DateTime.now()),
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
                                          labelText: ArchiveLocationActionFieldNames.name.message,
                                          onSaved: (value) => _archiveLocationInsertBody = 
                                          _archiveLocationInsertBody.copyWith(connectionUser: value),                                          
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
                                          maxLines: 10,
                                          maxLength: 255,
                                          labelText: ArchiveLocationActionFieldNames.caption.message,
                                          onSaved: (value) => _archiveLocationInsertBody = 
                                          _archiveLocationInsertBody.copyWith(caption: value),
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
                                          labelText: ArchiveLocationActionFieldNames.host.message,
                                          onSaved: (value) => _archiveLocationInsertBody = 
                                          _archiveLocationInsertBody.copyWith(connectionHost: value),                                          
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
                                          mandatory: true,
                                          maxLength: 255,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                            LengthLimitingTextInputFormatter(4)                                                
                                          ],
                                          labelText: ArchiveLocationActionFieldNames.port.message,
                                          onSaved: (value) => _archiveLocationInsertBody = 
                                          _archiveLocationInsertBody.copyWith(connectionPort: int.tryParse(value)),                                          
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
                                          labelText: ArchiveLocationActionFieldNames.nameBD.message,
                                          onSaved: (value) => _archiveLocationInsertBody = 
                                          _archiveLocationInsertBody.copyWith(databaseName: value),                                          
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
                                          onSaved: (value) => _archiveLocationInsertBody = _archiveLocationInsertBody.copyWith(connectionPassword: value),      
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
                                          value: _archiveLocationInsertBody.enabled ?? false,
                                          text: ArchiveLocationActionFieldNames.enable.message,
                                          onChanged: (value) => _archiveLocationInsertBody = _archiveLocationInsertBody.copyWith(enabled: value)                                                                               
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
      context.read<ArchiveLocationInsertBloc>().add(ArchiveLocationInsertRun(_archiveLocationInsertBody));
    }
  }  

  void _onBackTap() {
    if(AutoRouter.of(context).canPop()) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pushAndPopUntil(const ArchiveLocationRoute(), predicate: (route) => false);
    }
  }     
}
