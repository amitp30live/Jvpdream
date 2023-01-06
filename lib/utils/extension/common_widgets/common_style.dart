import 'dart:ui';
import 'package:flutter/material.dart';

class CommonStyle {
  static TextStyle getTextStyle() {
    return const TextStyle(
        color: Colors.white, backgroundColor: Colors.black45, fontSize: 17);
  }
}

class SnackbarClass {
  static createSnackBar(String message, BuildContext context) {
    // final snackBar =
    //     SnackBar(content: Text(message), backgroundColor: Colors.red[200]);
    // ScaffoldMessenger.of(contextMain).showSnackBar(snackBar);

    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
      duration: const Duration(seconds: 2),
      // backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class ThemeButton {
  static Widget btnRound(String text, methodPressed) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: methodPressed,
        child: Text(text, style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22), // <-- Radius
            ),
            backgroundColor: Colors.black45),
      ),
    );
  }
}

class CommonWidgets {
  // Screen size in density independent pixels
  static var screenWidth =
      (window.physicalSize.shortestSide / window.devicePixelRatio);
  static var screenHeight =
      (window.physicalSize.longestSide / window.devicePixelRatio);

  static Widget appIcon(double iconWidth) {
    return Center(
      child: SizedBox(
        width: iconWidth,
        height: iconWidth,
        child: Image.asset(
          'assets/images/apple.png',
          color: Colors.black54,
        ),
      ),
    );
  }

  //667*.05 = 33.35 ~ 34
  //667*.04 = 26.68 ~ 27
  //667*.035 = 23.345 ~ 24
  //667*.03 = 20.01 ~ 20

  //736*.05 = 36.8 ~ 37
  //736*.04 = 29.44 ~ 30
  //736*.035 = 25.76 ~ 26
  //736*.03 = 22.08 ~ 23

  //13 pro = 390 w * 844 h
  //844*.05 = 42.2 ~ 43
  //844*.04 = 33.76 ~ 34
  //844*.035 = 29.54 ~ 30
  //844*.03 = 25.32 ~

  //13pro max = 428 * 926

  static Widget containerWithHeight({double ratio = 0.04}) {
    return Container(height: getDynamicHeight(ratio: ratio));
  }

  static double getDynamicPadding({double ratio = 0.35}) {
    return (ratio * screenHeight).roundToDouble();
  }

  static double getDynamicHeight({double ratio = 0.04}) {
    return (ratio * screenHeight).roundToDouble();
  }
}
