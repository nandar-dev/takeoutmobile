import 'package:flutter/widgets.dart';

enum ScrollDirection { left, right }

void horizontalSlidingHandler(ScrollDirection direction, ScrollController controller) {
  double offsetChange = direction == ScrollDirection.right ? 200 : -200;
  
  controller.animateTo(
    controller.offset + offsetChange,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
}
