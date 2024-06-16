import 'dart:io';

import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/styles.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class ClaimInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: Platform.isIOS
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          const Text('Детализация требования'),
          BlocBuilder<ClaimInfoBloc, ClaimInfoState>(
            builder: (context, state) {
              Widget body = Container();
              if (state is ClaimInfoInitial) {
                body = Text(
                  state.serviceName,
                  style: const TextStyle(
                    fontSize: 12
                  ),
                );
              }
              return body;
            }
          ) 
        ],
      ),
    ),
    body: BlocBuilder<ClaimInfoBloc, ClaimInfoState>(
      builder: (context, state) {
        Widget body = Container();
        if (state is ClaimInfoLoading) {
          body = const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.maxFinite,
              ),
              LoadingIndicator()
            ],
          );
        }
        if (state is ClaimInfoInitial) {
          body = FullScreen(
            bottomSafe: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 16),
                QrPicture(
                  data: state.qrData,
                  size: 150
                ),
                const SizedBox(height: 16),
                // if ((state.devices?.length ?? 0) > 0)
                //   Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 16),
                //     child: DevicesButton(
                //       onTap: () => _showDevices(context, state.devices),
                //     ),
                //   ),
                InfoList(state.info),
                if (state.devices.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: ListTile(
                        title: Text(
                          'Приборы учета',
                          style: TextStyle(
                            color: AppStyles.mainTextColor.withOpacity(0.7),
                            fontSize: 14
                          ),
                        ),
                        subtitle: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.devices.length,
                          itemBuilder: (context, index) => DeviceItem(state.devices[index], index)
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        dense: true
                      ),
                    ),
                const SizedBox(height: 16)
              ]
            ),
          ); 
        }
        return body;
      }
    ),
  );

}