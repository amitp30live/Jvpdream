import 'package:flutter/material.dart';

class CommonStyle {
  static TextStyle getTextStyle() {
    return TextStyle(
        color: Colors.white, backgroundColor: Colors.black45, fontSize: 17);
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
}
