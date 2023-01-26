import 'package:doctovirt/elements/custom_inkwell.dart';
import 'package:doctovirt/them/colors.dart';
import 'package:flutter/material.dart';

Future<int?> showConfimMesage(context,
    {required String message,
    required String buttonConfirm,
    String titleText = ""}) async {
  // flutter defined function
  var val = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return DynamicAlertDialog(
        titleText: titleText,
        contentText: message,
        onCancel: () => Navigator.pop(context),
        onConfirm: () => Navigator.pop(context, 1),
        confirmColor: Color(0xffff6d5f),
        indicatorColor: Color(0xffff6d5f),
      );
    },
  );
  return val;
}

class DynamicAlertDialog extends StatefulWidget {
  final String? titleText;
  final String? contentText;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final Color? confirmColor;
  final Color? cancelColor;
  final Color? indicatorColor;

  DynamicAlertDialog(
      {this.titleText,
      this.contentText,
      this.confirmText,
      this.cancelText,
      required this.onCancel,
      required this.onConfirm,
      this.confirmColor,
      this.cancelColor,
      this.indicatorColor});

  @override
  _DynamicAlertDialogState createState() => _DynamicAlertDialogState();
}

class _DynamicAlertDialogState extends State<DynamicAlertDialog> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: !_loading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.titleText ?? "Alert",
                  style: const TextStyle(fontSize: 24.0),
                ),
                const Divider()
              ],
            )
          : const Text(''),
      content: !_loading
          ? Text(
              widget.contentText ?? "Are you sure?",
              style: const TextStyle(height: 1.8, fontSize: 17),
            )
          : SizedBox(
              height: 50,
              width: 40,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      widget.indicatorColor ?? AppColors.appMain100),
                ),
              ),
            ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      actions: !_loading
          ? [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInKWell(
                  child: Text(
                    widget.cancelText ?? "Cancel",
                    style: TextStyle(
                        color: widget.cancelColor ?? Colors.black87,
                        fontSize: 18.0),
                  ),
                  onTap: () {
                    setState(() {
                      _loading = false;
                    });
                    widget.onCancel();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInKWell(
                  child: Text(
                    widget.confirmText ?? "Confirm",
                    style: TextStyle(
                        color: widget.confirmColor ?? AppColors.appMain100,
                        fontSize: 18.0),
                  ),
                  onTap: () {
                    setState(() {
                      _loading = true;
                    });
                    widget.onConfirm();
                  },
                ),
              ),
            ]
          : [],
    );
  }
}
