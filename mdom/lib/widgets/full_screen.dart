// ignore_for_file: always_put_required_named_parameters_first

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FullScreen extends StatefulWidget {
  final bool leftSafe;
  final bool topSafe;
  final bool rightSafe;
  final bool bottomSafe;
  final double maxWidthConstraint;
  final double? maxHeightConstraint;

  final Widget child;
  final ScrollController? controller;

  const FullScreen({
    Key? key,
    this.leftSafe = true,
    this.topSafe = true,
    this.rightSafe = true,
    this.bottomSafe = true,
    this.maxWidthConstraint = 720.0,
    this.maxHeightConstraint,
    required this.child,
    this.controller,
  }) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController =
        widget.controller == null ? ScrollController() : widget.controller!;
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        left: widget.leftSafe,
        top: widget.topSafe,
        right: widget.rightSafe,
        bottom: widget.bottomSafe,
        child: LayoutBuilder(
          builder: (context, viewportConstraints) => Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
                primary: false,
                controller: scrollController,
                child: kIsWeb
                    ? Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: widget.maxHeightConstraint ??
                                viewportConstraints.maxHeight,
                            maxWidth: widget.maxWidthConstraint,
                          ),
                          child: widget.child,
                        ),
                      )
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                        child: widget.child,
                      )),
          ),
        ),
      );
}
