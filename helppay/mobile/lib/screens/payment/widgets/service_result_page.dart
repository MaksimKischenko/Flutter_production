import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:tuple/tuple.dart';

import 'widgets.dart';

class ServiceResultPage extends StatefulWidget {
  final ScrollController scrollController;
  final PayRecordResponse service;
  final List<AttrRecordRequest> lastAttrs;
  final List<Tuple2<String, dynamic>> finishedAttrs;

  const ServiceResultPage(
      {required this.scrollController,
      required this.service,
      required this.lastAttrs,
      required this.finishedAttrs});

  @override
  _ServiceResultPageState createState() => _ServiceResultPageState();
}

class _ServiceResultPageState extends State<ServiceResultPage> {
  final _titleKey = GlobalKey();

  double get titleSize => 40;

  bool _isTitleVisible = false;

  bool get _showTitle =>
      (widget.scrollController.hasClients) &&
      widget.scrollController.offset - titleSize > 0;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(
      () {
        if (_isTitleVisible != _showTitle) {
          setState(() {
            _isTitleVisible = !_isTitleVisible;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
          title: _showTitle
              ? Text(
                  widget.service.name ?? '',
                  style: const TextStyle(color: AppStyles.mainColorDark),
                )
              : null,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        // padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                        child: PageTitle(
                            key: _titleKey, text: widget.service.name ?? ''),
                      ),
                      // ProductsCarousel(
                      //   dataManager: InjectionComponent.getDependency<DataManager>(),
                      //   onProductSelected: (product) => print('product selected'),
                      // ),
                      // SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        itemCount: widget.finishedAttrs.length,
                        itemBuilder: (context, index) => _buildItem(index),
                        separatorBuilder: (context, _) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Divider(
                              color: AppStyles.mainColorDark.withOpacity(0.1)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: SumText(widget.service.summa ?? 0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NextButton(
                  onPressed: _onPayTap,
                  text: context
                      .t.mobileScreens.payment.serviceResultPage.nextButton,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget _buildItem(int index) {
    final attr = widget.finishedAttrs[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          attr.item1,
          style: TextStyle(
              color: AppStyles.mainColorDark.withOpacity(0.6),
              fontSize: 16,
              letterSpacing: -0.5),
        ),
        const SizedBox(height: 8),
        Text(
          '${attr.item2}',
          style: const TextStyle(
            color: AppStyles.mainColorDark,
            fontSize: 16,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  void _onPayTap() {
    context.read<PaymentBloc>().add(
        PaymentRunOperation(service: widget.service, attrs: widget.lastAttrs));
  }
}
