import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_status/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';


class ArchiveStatusScreenBody extends StatelessWidget {
  const ArchiveStatusScreenBody({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text('Справочник статусов', style: AppStyles.headerStyle)
        ),
        const SizedBox(height: 12),        
        BlocConsumer<ArchiveStatusBloc, ArchiveStatusState>(
          listener: (context, state) {
            if(state is ArchiveStatusError) {
              RequestUtil.catchNetworkError(
                context: context,
                obj: state.error
              );               
            }
          },
          builder: (context, state) {
            Widget body = const SizedBox();     
            if(state is ArchiveStatusLoading) {
              body = const Expanded(
                child: Center(child: LoadingIndicator(indicatorsSize: 72)),
              );                    
            } else if (state is ArchiveStatusLoaded) {
              body = Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ArchiveStatusTable(
                        archiveStatuses: state.statuses,
                      )
                    ),
                  ],
                ),
              );
            }             
            return body;
          },
        )
      ],
    ),
  );
}
