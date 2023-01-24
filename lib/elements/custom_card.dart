import 'package:flutter/material.dart';

class CustomCardW extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsets? paddings;
  final EdgeInsets? margins;
  final double radius;
  final bool withShadow;
  final double? height;
  final bool defaultPadings;
  final bool defaultMargins;

  const CustomCardW(
      {Key? key,
      required this.child,
      this.color = Colors.white,
      this.paddings,
      this.radius = 5,
      this.withShadow = true,
      this.margins,
      this.height,
      this.defaultPadings = true,
      this.defaultMargins = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultPadings ? const EdgeInsets.all(20) : paddings,
      margin: defaultMargins ? const EdgeInsets.all(20) : margins,
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          withShadow
              ? const BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              : const BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 0,
                  offset: Offset(0, 0),
                ),
        ],
      ),
      child: child,
    );
  }
}
