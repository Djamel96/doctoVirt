import 'package:flutter/material.dart';

import 'custom_card.dart';

class MoreButton extends StatelessWidget {
  final String title;
  final String icon;
  final double size;
  final GestureTapCallback? action;
  final Color? iconColor;
  final Color? textColor;
  final bool showForwardIcon;

  const MoreButton({
    Key? key,
    required this.title,
    required this.icon,
    this.action,
    this.size = 27,
    this.iconColor,
    this.textColor,
    this.showForwardIcon = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(
        5,
      ),
      onTap: action,
      child: CustomCardW(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: 40,
              child: SvgPicture.asset(
                icon,
                fit: BoxFit.contain,
                height: size,
                width: size,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 7),
            Text18w700(
              text: title,
              color: textColor ?? MyColors.appMain100,
            ),
            const Spacer(),
            showForwardIcon ? const ForwardIcon() : const Center(),
          ],
        ),
      ),
    );
  }
}
