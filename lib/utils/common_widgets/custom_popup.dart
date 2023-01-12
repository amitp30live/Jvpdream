import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String? positiveBtnText;
  final String? negativeBtnText;
  final Function onPostivePressed;
  final Function? onNegativePressed;
  final double circularBorderRadius;

  const CustomAlertDialog({
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    required this.onPostivePressed,
    this.onNegativePressed,
  }) : assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: message != null ? Text(message) : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        // ignore: unnecessary_null_comparison
        if (negativeBtnText != null)
          TextButton(
            child: Text(negativeBtnText!),
            //   textColor: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pop();
              onNegativePressed!();
            },
          )
        else if (positiveBtnText != null)
          TextButton(
              child: Text(positiveBtnText!),
              // textColor: Theme.of(context).accentColor,
              onPressed: () {
                onPostivePressed();
              })
        else
          Text(""),
      ],
    );
  }
}
