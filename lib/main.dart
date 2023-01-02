import 'package:flutter/material.dart';
import 'package:jvdream/ui/InitialUI.dart';
import 'package:jvdream/ui/LoginUI.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      home: InitialUI(),
    );
  }
}

//Font Size Dynamic
//Each Height needs to b dynamic as per device height
