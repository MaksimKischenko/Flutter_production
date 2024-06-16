import 'package:flutter/material.dart';

///
/// Work of animation get from carousel_slider
/// 
class Carousel extends StatefulWidget {
  final int initialPage;
  final double height;
  final int itemCount;
  final Function(int index) onItemSelected;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const Carousel({
    required this.itemCount,
    required this.onItemSelected,
    required this.itemBuilder,
    this.initialPage = 0,
    this.height = 95
  });

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController pageController;

  void update() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      viewportFraction: 0.9,
      initialPage: widget.initialPage
    );
    pageController.addListener(update);
  }

  @override
  void dispose() {
    pageController
      ..removeListener(update)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onVerticalDragStart: (_) {},
    child: SizedBox(
      height: widget.height,
      child: PageView.builder(
        itemCount: widget.itemCount,
        controller: pageController,
        onPageChanged: widget.onItemSelected,
        itemBuilder: (context, index) {
          final child = widget.itemBuilder(context, index);
          
          double itemOffset;

          final storageContext = pageController.position.context.storageContext;
          final previousSavedPosition = PageStorage.of(storageContext).readState(storageContext) as double?;

          if (previousSavedPosition != null) {
            itemOffset = previousSavedPosition - index;
          } else {
            itemOffset = 0.0 - index;
          }

          return Align(
            child: Opacity(
              opacity: (1.0 - itemOffset.abs() * 0.6).clamp(0.0, 1.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.width * (1.0 / 0.6),
                width: double.maxFinite,
                child: child,
              ),
            ),
          );
        },
      ),
    ),
  );
}