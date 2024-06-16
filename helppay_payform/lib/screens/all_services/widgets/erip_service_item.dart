import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';

import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/navigation.dart';
import 'package:helppay_payform_app/screens/all_services/widgets/erip_item_with_hover.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/utils/loger.dart';
import 'package:helppay_payform_app/utils/utils.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'erip_service_item');

class EripServiceItem extends StatefulWidget {
  final EripService item;
  final Function(int code, int diType, String name) onServiceTap;

  const EripServiceItem({
    Key? key,
    required this.item,
    required this.onServiceTap,
  }) : super(key: key);

  @override
  State<EripServiceItem> createState() => _EripServiceItemState();
}

class _EripServiceItemState extends State<EripServiceItem> {
  bool _isNodeExpanded = false;

  void onTap(
    bool isNodeExpanded,
    EripService item,
  ) {
    if (widget.item.type == EripServiceType.node) {
      if (!isNodeExpanded) {
        // widget.item.nodeBloc ??= AllServicesNodeBloc(
        //   dataManager: InjectionComponent.getDependency<DataManager>(),
        //   payCode: widget.item.code
        // )..add(AllServicesNodeInit());
        // on expand
        if (widget.item.nodeBloc?.state is AllServicesNodeInitial ||
            widget.item.nodeBloc?.state is AllServicesNodeError ||
            widget.item.nodeBloc?.state is AllServicesNodeErrorKomplat) {
          widget.item.nodeBloc?.add(AllServicesNodeInit());
        }
      }
      setState(() {
        _isNodeExpanded = !isNodeExpanded;
      });
    } else {
      // service
      widget.onServiceTap(
          widget.item.code, widget.item.diType, widget.item.name);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          EripItemWithHover(
            item: widget.item,
            onServiceTap: widget.onServiceTap,
            isNodeExpanded: _isNodeExpanded,
            onTap: (bool isNodeExpanded, EripService item) =>
                onTap(isNodeExpanded, item),
          ),
          if (_isNodeExpanded)
            BlocBuilder<AllServicesNodeBloc, AllServicesNodeState>(
              bloc: widget.item.nodeBloc,
              builder: (context, state) {
                Widget body = Container();
                if (state is AllServicesNodeLoading) {
                } else if (state is AllServicesNodeLoaded) {
                  body = ListView.separated(
                    padding: const EdgeInsets.only(left: 24),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.services.length,
                    itemBuilder: (context, index) => EripServiceItem(
                      item: state.services[index],
                      onServiceTap: Navigation.toService,
                    ),
                    separatorBuilder: (context, _) => Divider(
                      height: 1,
                      color: AppStyles.secondaryTextColor.withOpacity(0.4),
                    ),
                  );
                } else if (state is AllServicesNodeError) {
                  body = PageError(
                    message: RequestUtil.kNetworkError,
                    onRepeatTap: () =>
                        widget.item.nodeBloc?.add(AllServicesNodeInit()),
                  );
                } else if (state is AllServicesNodeErrorKomplat) {
                  body = PageError(
                    message: state.errorText ?? 'Неизвестная ошибка',
                    onRepeatTap: () =>
                        widget.item.nodeBloc?.add(AllServicesNodeInit()),
                  );
                }
                return body;
              },
            )
        ],
      );
}
