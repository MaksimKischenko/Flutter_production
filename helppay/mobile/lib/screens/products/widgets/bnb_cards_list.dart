import 'package:flutter/material.dart';


class BNBCardsList extends StatelessWidget {
  final Function() onTap;

  const BNBCardsList({required this.onTap});

  @override
  Widget build(BuildContext context) => const Padding(
      padding: EdgeInsets.only(top: 16, bottom: 64),
      child: Column(
        children: [
          // ListView.builder(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     padding: const EdgeInsets.symmetric(vertical: 16),
          //     itemCount: state.cardsList.length,
          //     itemBuilder: (context, index) => CardItem(
          //           card: state.cardsList[index],
          //           onTap: onTap,
          //         )),
        ],
      ),
    );
}
