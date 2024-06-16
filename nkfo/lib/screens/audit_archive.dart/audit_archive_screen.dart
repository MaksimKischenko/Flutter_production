import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:web_cabinet_nkfo/blocs/blocs.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/navigation.dart';
import 'package:web_cabinet_nkfo/styles.dart';
import 'package:web_cabinet_nkfo/utils/utils.dart';
import 'package:web_cabinet_nkfo/widgets/widgets.dart';

import 'widgets/archive_run_button.dart';

class AuditArchiveScreen extends StatefulWidget {
  static const pageName = 'Архивирование событий';

  

  @override
  _AuditArchiveScreenState createState() => _AuditArchiveScreenState();
}

class _AuditArchiveScreenState extends State<AuditArchiveScreen> {
  
  final _formKey = GlobalKey<FormState>();
  DateTime? _sendingDate;
  AuditApplication? _selectedApplication;
  double width = 1200; 


  @override
  Widget build(BuildContext context) => BlocListener<AuditArchiveBloc,AuditArchiveState>(
    listener: (context, state) {
      if(state is AuditArchiveError) {
         RequestUtil.catchNetworkError(context: context, obj: state.error);
      } else if (state is AuditArchiveSuccess) {
          if(Navigator.of(context).canPop()) {
            Navigator.of(context).pop();    
          } else {
            Navigation.toAudit();        
          }
        Multiplatform.showMessage(
          context: context,
          title: 'Успешно',
          message: state.response,
          type: DialogType.success
        );
      }
    },
    child: Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonAppBar(
              title: 'Архивирование событий',
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<AuditArchiveBloc,AuditArchiveState>(
                builder: (context, state) {
                  Widget body = Container();
                  if(state is AuditArchiveInitError) {
                    body = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: double.maxFinite),
                        const Text('Невозможно начать процедуру создания'),
                        const SizedBox(height: 8),
                        CupertinoButton(
                          onPressed: () => context
                              .read<AuditArchiveBloc>()
                              .add(AuditArchiveInit()),
                          child: const Text('Попробовать снова', style: TextStyle(color: AppStyles.mainColor)),
                        )
                      ],
                    );
                  } else if (state is AuditArchiveInitLoading) {
                    body = const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.maxFinite),
                        LoadingIndicator()
                      ],
                    );
                  } else if (state is AuditArchiveLoaded) {
                    body = ResponsiveBuilder(
                      builder:(context, sizingInformation) {
                          if (sizingInformation.isMobile || sizingInformation.isTablet) {
                            width = sizingInformation.screenSize.width;
                        }
                        return Container(
                          width: width,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                          child: Form(
                            key: _formKey,
                            child: Responsive(
                              runSpacing: 16,
                              children: [
                                Div(
                                  colL: 3,
                                  colM: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: TextFieldDropdownSearch<AuditApplication>(
                                      title: 'Приложение',
                                      showSearchBox: false,
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
                                  colM: 12,
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: WebDatePicker(
                                      mandatory: true,
                                      labelText: 'Дата',
                                      onChange: (value) => _sendingDate = value,
                                      validator: () => null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } 
                    );
                  }
                  return body;
                },
              )
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UndoButton(onTap: () {
                    if(Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        Navigation.toAudit();
                      }
                  }),
                  const SizedBox(width: 10),
                  ArchiveRunButton(onTap:_onRunAuditArchive)
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

   void _onRunAuditArchive(){
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

     Multiplatform.showDecisionMessage(
      context: context,
      message: '',
      action: () => context.read<AuditArchiveBloc>().add(AuditArchiveRun(
      application: _selectedApplication?.name == null? 0.toString(): _selectedApplication!.typeId.toString(), 
      dateFrom: _sendingDate
      )),
      dialogTitle: 'Выгруженные в архив записи будут удалены из журнала аудита?',
      buttonTitle: 'Архивировать',
      cancelButtonTitle: 'Нет'
    );
   }
  }
}