import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_tracking_module/presentation/bloc/blocs.dart';
import 'package:payment_tracking_module/presentation/styles.dart';
import 'package:payment_tracking_module/presentation/widgets/widgets.dart';
import 'package:payment_tracking_module/utils/utils.dart';

import 'widgets.dart';

class MapAllocationScreenBody extends StatelessWidget {
  const MapAllocationScreenBody({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text('Карта распределения архивов', style: AppStyles.headerStyle)
        ),
        const SizedBox(height: 12),        
        BlocConsumer<MapAllocationBloc, MapAllocationState>(
          listener: (context, state) {
            if(state is MapAllocationError) {
              RequestUtil.catchNetworkError(
                context: context,
                obj: state.error
              );                
            }
          },
          builder: (context, state) {
            Widget body = const SizedBox();     
            if(state is MapAllocationLoading) {
              body = const Expanded(
                child: Center(child: LoadingIndicator(indicatorsSize: 72)),
              );                    
            } else if (state is MapAllocationLoaded) {
              body = Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: MapAllocationTable(
                        mapAllocations: state.mapAllocations,
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
