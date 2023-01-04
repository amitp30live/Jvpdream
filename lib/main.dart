import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/ui/HomeUI.dart';
import 'package:jvdream/ui/InitialUI.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Auth _auth = Auth();

  bool isLogged = await _auth.isLogged();

  runApp(RootApp(isLoggedIn: isLogged));
}

class RootApp extends StatelessWidget {
  final bool isLoggedIn;
  RootApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      home: isLoggedIn ? HomeUI() : InitialUI(),
    );
  }
}

class Auth {
  Future<bool> isLogged() async {
    try {
      SharedPreferences shared_User = await SharedPreferences.getInstance();

      if (shared_User.getString('user') != null) {
        Map userMap = jsonDecode(shared_User.getString('user')!);
        var user = UserModel.fromJson(userMap);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

//Font Size Dynamic
//Each Height needs to b dynamic as per device height
