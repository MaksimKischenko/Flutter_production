import 'package:flutter/material.dart';

class FiltersCarousel extends StatefulWidget{
  final List<String> items;

  const FiltersCarousel({
    required this.items
  });

  @override
  _FiltersCarousel createState() => _FiltersCarousel();
}

class _FiltersCarousel extends State<FiltersCarousel> {
  

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: _buildList()
    ),
  );

  List<Widget> _buildList() => widget.items.map((item) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Chip(
      backgroundColor: Theme.of(context).primaryColorLight,
      label: Text(
        item,
        style: TextStyle(
          color: Theme.of(context).primaryColor
        ),
      )
    )
  )).toList();
}