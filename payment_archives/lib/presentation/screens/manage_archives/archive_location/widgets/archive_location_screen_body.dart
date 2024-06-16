import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_location/listeners/listeners.dart';
import 'package:payment_tracking_module/presentation/screens/manage_archives/archive_location/widgets/widgets.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';

class ArchiveLocationScreenBody extends StatefulWidget {
  const ArchiveLocationScreenBody({super.key});

  @override
  State<ArchiveLocationScreenBody> createState() =>
      _ArchiveLocationScreenBodyState();
}

class _ArchiveLocationScreenBodyState extends State<ArchiveLocationScreenBody> {

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
  Widget build(BuildContext context) {
    bool? _isSelected;
    ArchiveLocation? _archiveLocation;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text('Справочник локаций баз данных', style: AppStyles.headerStyle)
          ),
          const SizedBox(height: 24),          
          BlocConsumer<RowSelectedBloc<ArchiveLocation>, RowSelectedState<ArchiveLocation>>(
            listener: (context, state) {
              _isSelected = state.selectedData.isSelected;
              _archiveLocation = state.selectedData.selectedObject;
            },
            builder: (context, state) => ArchiveLocationMenu(
              isSelected: _isSelected ?? false,
              archiveLocation: _archiveLocation,
            ),
          ),
          BlocConsumer<ArchiveLocationBloc, ArchiveLocationState>(            
            listener: (context, state) => ArchiveLocationsListener.fromActions(
              context, 
              state, 
              () => null
            ),
            builder: (context, state) {
              Widget body = const SizedBox();
              if (state is ArchiveLocationLoading) {
                body = const Expanded(
                  child: Center(child: LoadingIndicator(indicatorsSize: 72)),
                );
              } else if (state is ArchiveLocationLoaded) {
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
                                child: ArchiveLocationTable(
                                  archiveLocations: state.archiveLocations,
                                ),
                              )
                            )
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
    );
  }  
}
