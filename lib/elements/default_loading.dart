import 'package:flutter/material.dart';

import '../them/colors.dart';

class Loading extends StatelessWidget {
  final Color color;
  final Color? backgroundColor;
  final double? height;
  final double? width;

  const Loading(
      {Key? key,
      this.color = AppColors.appMain100,
      this.height,
      this.width,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: backgroundColor ?? Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      )),
    );
  }
}
