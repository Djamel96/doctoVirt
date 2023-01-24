import 'package:flutter/material.dart';

class CustomInKWell extends StatelessWidget {
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final Widget child;

  const CustomInKWell({
    Key? key,
    this.onTap,
    required this.child,
    this.onLongPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
    );
  }
}

class MyInKWellCollored extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget child;
  final Color color;

  const MyInKWellCollored(
      {Key? key,
      this.onTap,
      required this.child,
      this.color = const Color(0xffF3F5FF)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        focusColor: color,
        splashColor: color,
        hoverColor: color,
        highlightColor: color,
        child: child,
      ),
    );
  }
}
