import 'package:doctovirt/elements/default_loading.dart';
import 'package:flutter/material.dart';

import '../them/colors.dart';

class RoundedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String content;
  final Color backgroundColor;
  final Color splashColor;
  final GestureTapCallback? onPressed;
  final Border? border;
  final List<BoxShadow>? shadow;
  final EdgeInsets? contentPadding;
  final bool active;
  final bool loading;
  RoundedButton({
    this.width,
    this.height,
    required this.content,
    this.onPressed,
    this.backgroundColor = AppColors.appMain100,
    this.splashColor = AppColors.buttonSplash,
    this.shadow,
    this.border,
    this.contentPadding,
    this.active = true,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: active ? (backgroundColor) : AppColors.appMain50,
            border: border,
            borderRadius: BorderRadius.circular(32),
            boxShadow: !active
                ? null
                : shadow ??
                    [
                      const BoxShadow(
                          color: AppColors.buttonShadow1,
                          offset: Offset(0, 6),
                          blurRadius: 6,
                          spreadRadius: -1),
                      const BoxShadow(
                          color: AppColors.buttonShadow2,
                          offset: Offset(0, 0),
                          blurRadius: 1,
                          spreadRadius: 0)
                    ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              //  height: REGULAR_BUTTON_HEIGHT,
              width: width ?? double.infinity,
              child: InkWell(
                splashColor: splashColor,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                onTap: onPressed,
                child: Container(
                  height: height ?? 60,
                  alignment: Alignment.center,
                  child: loading
                      ? const Loading()
                      : Text(
                          content,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
