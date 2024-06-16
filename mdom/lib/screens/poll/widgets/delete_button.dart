import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onTap;

  const DeleteButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
    icon: SvgPicture.asset('assets/icon/poll_delete.svg'),
    onPressed: onTap,
  );
}