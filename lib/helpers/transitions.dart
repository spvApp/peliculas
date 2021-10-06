import 'package:flutter/cupertino.dart';

class CustomSizeTransition extends PageRouteBuilder {
  final Widget widget;

  CustomSizeTransition(this.widget)
      : super(
            pageBuilder: (_, Animation<double> animation,
                Animation<double> animationSecond) {
              return widget;
            },
            transitionsBuilder: (_, Animation<double> animation,
                Animation<double> animationSecond, Widget child) {
              return Align(
                alignment: Alignment.bottomLeft,
                child: SizeTransition(sizeFactor: animation, child: child),
              );
            },
            transitionDuration: Duration(milliseconds: 500),
            reverseTransitionDuration: Duration(milliseconds: 500));
}
