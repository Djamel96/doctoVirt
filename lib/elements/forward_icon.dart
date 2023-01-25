import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForwardIcon extends StatelessWidget {
  const ForwardIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/nav_right_arrow.svg");
  }
}
