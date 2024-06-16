import 'package:auto_route/auto_route.dart';
import 'package:bpc/blocs/blocs.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/utils/utils.dart';
import 'package:bpc/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/widgets.dart';


@RoutePage()
class ServicesQrScreen extends StatefulWidget {
  static const pageRoute = '/services/qr';

  const ServicesQrScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ServicesQrScreenState createState() => _ServicesQrScreenState();
}

class _ServicesQrScreenState extends State<ServicesQrScreen> {
  final _serviceController = TextEditingController();

  double get _qrFrameSize => 180;

  @override
  void dispose() {
    _serviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: kIsWeb
              ? const WebCabinetMenu(selectedIndex: 2)
              : const Text('QR-коды услуг'),
          automaticallyImplyLeading: false,
        ),
        body: WebConstrainedBox(
          child: BlocBuilder<ServicesQrBloc, ServicesQrState>(
            builder: (context, state) {
              Widget body = Container();
              if (state is ServicesQrLoading) {
                body = Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: double.maxFinite,
                    ),
                    LoadingIndicator()
                  ],
                );
              }
              if (state is ServicesQrUnavailable) {
                body = Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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
                                services: state.available,
                                selected: state.selected),
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
                    ));
              }
              return body;
            },
          ),
        ),
      );

  // ignore: avoid_void_async
  void _showServicesDropDown({
    required List<Service> services,
    required Service selected,
  }) async {
    final service = await Multiplatform.showDropdown<Service>(
      context: context,
      title: 'Услуга',
      items: services,
      builder: (item) => item.name,
      selected: selected,
    );
    if (service != null) {
      context.read<ServicesQrBloc>().add(ServicesQrSelected(service));
    }
  }
}
