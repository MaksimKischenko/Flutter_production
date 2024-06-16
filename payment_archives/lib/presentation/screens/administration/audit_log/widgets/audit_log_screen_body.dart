
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/administration/audit_log/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';


class AuditLogScreenBody extends StatefulWidget {
  const AuditLogScreenBody({super.key});

  @override
  State<AuditLogScreenBody> createState() => _AuditLogScreenBodyState();
}

class _AuditLogScreenBodyState extends State<AuditLogScreenBody> {

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(); 
  }

 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
        Center(
          child: Text('Журнал аудита', style: AppStyles.headerStyle)
        ),  
        const SizedBox(height: 24),                          
        LayoutBuilder(
          builder: (context, constraints) {
            final _isNormalSize = constraints.maxWidth > 900 && constraints.maxHeight > 300;
            if(!_isNormalSize) {
              return const SizedBox.shrink();
            } else {
              return SearchAuditLogMenu();
            }
          }
        ),   
        BlocConsumer<AuditLogBloc, AuditLogState>(
          listener: (context, state) {
            if(state is AuditLogNetworkError) {
              RequestUtil.catchNetworkError(
                context: context,
                obj: state.error
              );               
            }
          },
          builder: (context, state) {
            Widget body = const SizedBox();
            if (state is AuditLogLoading) {
              body = const Expanded(
                child: Center(
                  child: LoadingIndicator(indicatorsSize: 72)
                ),
              );                  
            } else if (state is AuditLogLoaded) {
              body = Expanded(
                child: Column(
                  children: [                  
                    Expanded(
                      child: RawScrollbar(
                        thumbColor: AppStyles.colorGrey2,
                        thumbVisibility: true,
                        interactive: true,
                        controller: _controller,                                
                        child: SingleChildScrollView(
                          controller: _controller,                            
                          scrollDirection: Axis.horizontal,                                
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,      
                            child: AuditLogTable(
                              auditLogs: state.audits,
                            ),
                          ),
                        ),
                      )             
                    ),                 
                  ],
                ),
              );                  
            }
          return body;
          }
        )
      ],
    ),
  );
}
