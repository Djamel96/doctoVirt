import 'package:doctovirt/elements/custom_inkwell.dart';
import 'package:flutter/material.dart';

class ToolBarButton extends StatelessWidget {
  final GestureLongPressCallback? onTap;
  final Widget child;
  final Color backColor;

  const ToolBarButton(
      {Key? key,
      this.onTap,
      required this.child,
      this.backColor = const Color(0xffffffff)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomInKWell(
      onTap: onTap,
      child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                    color: Color(0xfff3f3f3),
                    offset: Offset(0, 6),
                    blurRadius: 6,
                    spreadRadius: -1),
                BoxShadow(
                    color: Color(0x0f0a1646),
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0)
              ],
              color: backColor),
          child: child),
    );
  }
}
