import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_avail_loc/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';

class AvailableArchiveLocationScreenBody extends StatefulWidget {
  const AvailableArchiveLocationScreenBody({super.key});

  @override
  State<AvailableArchiveLocationScreenBody> createState() => _AvailableArchiveLocationScreenBodyState();
}

class _AvailableArchiveLocationScreenBodyState extends State<AvailableArchiveLocationScreenBody> {
  
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
  Widget build(BuildContext context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Справочник расположения баз данных архивов', style: AppStyles.headerStyle)
            ),
            const SizedBox(height: 12),            
            BlocConsumer<AvailableArchiveLocationBloc, AvailableArchiveLocationState>(
              listener: (context, state) {
                if(state is AvailableArchiveLocationError) {
                  RequestUtil.catchNetworkError(
                    context: context,
                    obj: state.error
                  );                    
                }
              },
              builder: (context, state) {
                Widget body = const SizedBox();     
                if(state is AvailableArchiveLocationLoading) {
                  body = const Expanded(
                    child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                  );                    
                } else if (state is AvailableArchiveLocationLoaded) {
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
                              child:  SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.2,
                                  child: AvailableArchiveLocationTable(
                                    availableArchiveLocations: state.archiveLocations,
                                  )),
                            ),
                          ),
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
      ),
    );
}
