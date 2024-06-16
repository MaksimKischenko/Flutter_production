import 'package:bpc_nkfo/blocs/blocs.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:bpc_nkfo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/widgets.dart';

class ServicesQrScreen extends StatefulWidget {
  @override
  _ServicesQrScreenState createState() => _ServicesQrScreenState();
}

class _ServicesQrScreenState extends State<ServicesQrScreen> {
  final _serviceController = TextEditingController();

  @override
  void dispose() {
    _serviceController.dispose();
    super.dispose();
  }

  double get _qrFrameSize => 180;

  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: const BpcDrawer(isServicesQrSelected: true),
      appBar: AppBar(
        title: const Text('QR-коды услуг'),
      ),
      body: BlocBuilder<ServicesQrBloc, ServicesQrState>(
        builder: (context, state) {
          Widget body = Container();
          if (state is ServicesQrLoading) {
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
          if (state is ServicesQrUnavailable) {
            body = const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.maxFinite,
                ),
                Text('Данная функция Вам недоступна')
              ],
            );
          }
          if (state is ServicesQrInitial) {
            _serviceController.text = state.selected.name;

            body = SafeArea(
              top: false,
              bottom: false,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ServiceField(
                      controller: _serviceController,
                      onTap: () => _showServicesDropDown(
                        context: context,
                        available: state.available,
                        selected: state.selected
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: _qrFrameSize,
                      height: _qrFrameSize,
                      child: Stack(
                        children: [
                          Center(
                            child: QrPicture(
                              data: state.qrData,
                              size: _qrFrameSize - 10,
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: SvgPicture.asset(
                              'assets/icon/qr_frame.svg',
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Spacer(flex: 3),
                  ],
                ),
              )
            );
          }
          return body;
        },
      )
    );

  // ignore: avoid_void_async
  void _showServicesDropDown({
    required BuildContext context,
    required List<Service> available,
    required Service selected
  }) async {
    final service = await Multiplatform.showDropDown(
      context: context,
      list: available,
      visibleList: available.map((item) => item.name).toList(),
      selected: selected,
      title: 'Услуга'
    );
    if (service != null) {
      context.read<ServicesQrBloc>().add(ServicesQrSelected(service));
    }
  }
}