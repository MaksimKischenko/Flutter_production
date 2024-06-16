import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_payform_app/blocs/blocs.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/widgets/widgets.dart';

class EripItemWithHover extends StatefulWidget {
  final EripService item;
  final bool isNodeExpanded;
  final Function(int code, int diType, String name) onServiceTap;
  final Function(bool isNodeExpanded, EripService item) onTap;

  const EripItemWithHover({
    Key? key,
    required this.item,
    required this.isNodeExpanded,
    required this.onServiceTap,
    required this.onTap,
  }) : super(key: key);

  @override
  State<EripItemWithHover> createState() => _EripItemWithHoverState();
}

class _EripItemWithHoverState extends State<EripItemWithHover> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => widget.onTap(widget.isNodeExpanded, widget.item),
      child: MouseRegion(
        cursor: MouseCursor.uncontrolled,
        onHover: _onHover,
        onExit: _onExit,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              if (widget.item.type == EripServiceType.node)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: BlocBuilder<AllServicesNodeBloc, AllServicesNodeState>(
                    bloc: widget.item.nodeBloc,
                    builder: (context, state) {
                      if (state is AllServicesNodeLoading) {
                        return const SizedBox(
                            width: 18, height: 18, child: LoadingIndicator());
                      } else {
                        return Icon(
                          widget.isNodeExpanded
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_right_outlined,
                          color: AppStyles.mainTextColor,
                          size: 18,
                        );
                      }
                    },
                  ),
                ),
              Expanded(
                child: Text(
                  widget.item.name,
                  style: TextStyle(
                      fontSize: 16,
                      color: _isHover
                          ? AppStyles.mainColor
                          : AppStyles.mainTextColor),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _onHover(PointerEvent details) {
    setState(() {
      _isHover = true;
    });
  }

  void _onExit(PointerEvent details) {
    setState(() {
      _isHover = false;
    });
  }
}
