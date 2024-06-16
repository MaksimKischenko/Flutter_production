import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpm_fl/blocs/blocs.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/widgets/widgets.dart';

class PopularServiceItem extends StatefulWidget {
  final ListPopularResponsePayRecord item;
  final Function(int code) onNodeTap;
  final Function(int code) onServiceTap;

  const PopularServiceItem({
    Key? key,
    required this.item,
    required this.onNodeTap,
    required this.onServiceTap
  }) : super(key: key);

  @override
  State<PopularServiceItem> createState() => _PopularServiceItemState();
}

class _PopularServiceItemState extends State<PopularServiceItem> {
  @override
  Widget build(BuildContext context) => BlocBuilder<BasketBloc, BasketState>(
    builder: (context, state) {
      if (state is BasketLoading) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppStyles.mainColor.withOpacity(.2)),
            borderRadius: BorderRadius.circular(8)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: LoadingIndicator(),
              )
            ],
          ),
        );
      } else {
        return InkWrapper(
          onTap: () => widget.item.recordType == 1
              ? widget.onNodeTap(widget.item.code!)
              : _onServiceTap(),
          borderRadius: 8,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppStyles.mainColor.withOpacity(.2)),
              borderRadius: BorderRadius.circular(8)
            ),
            child: widget.item.picture?.url == null
            ? _serviceTitle()
            // TODO: add /imgs to resourcesUrl or remove it from GetUserProfile response
            : Image.network('${SettingsInfo.of(context).resourcesUrl}/imgs/${widget.item.picture!.url!}',
              // fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _serviceTitle(),
            ),
          ),
        );
      }
    }
  );

  Widget _serviceTitle() => Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Text(
      widget.item.name ?? 'Неизвестно',
      style: const TextStyle(
        color: AppStyles.mainTextColor,
        fontSize: 16,
        overflow: TextOverflow.visible
      ),
      // textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ),
  );

  void _onServiceTap() {
    final basket = context.read<BasketBloc>();
    if (basket.kioskReceipt != null) {
      widget.onServiceTap(widget.item.code!);
    } else {
      // try to open
      late StreamSubscription<BasketState> basketListener;
      basketListener = basket.stream.listen((state) {
        if (state is BasketOpened) {
          widget.onServiceTap(widget.item.code!);
          basketListener.cancel();
        }
      });
      basket.add(BasketInit());
    }
  }
}