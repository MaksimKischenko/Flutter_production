// ignore_for_file: always_put_required_named_parameters_first

import 'dart:async';

import 'package:flutter/material.dart';

class CountdownBpc extends StatefulWidget {
  final Duration duration;
  final Widget Function(BuildContext context, Duration remaining, _CountdownBpcState state) builder;
  final void Function()? onFinish;
  final void Function()? onStop;
  final Duration interval;

  const CountdownBpc({
    Key? key,
    required this.duration,
    required this.builder,
    this.onFinish,
    this.onStop,
    this.interval = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _CountdownBpcState createState() => _CountdownBpcState();
}

class _CountdownBpcState extends State<CountdownBpc> {
  Timer? _timer;
  late Duration _duration;
  
  @override
  void initState() {
    _duration = widget.duration;
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(widget.interval, timerCallback);
  }

  void stopTimer() {
    _timer?.cancel();
    widget.onStop?.call();
  }

  void timerCallback(Timer timer) {
    setState(() {
      if (_duration.inSeconds == 0) {
        timer.cancel();
        if (widget.onFinish != null) widget.onFinish?.call();
      } else {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _duration, this);
}