import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/ui/HomeUI.dart';
import 'package:jvdream/ui/InitialUI.dart';
import 'package:jvdream/ui/TabScreens/Tabbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Auth _auth = Auth();

  bool isLogged = await _auth.isLogged();
  if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    // Use location.
    print("allowed");
  }
  // You can request multiple permissions at once.
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
    Permission.camera,
  ].request();
  print(statuses[Permission.location]);

  runApp(RootApp(isLoggedIn: isLogged));
}

class RootApp extends StatelessWidget {
  final bool isLoggedIn;
  RootApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      home: isLoggedIn ? TabbarPage() : InitialUI(),
    );
  }
}

class Auth {
  Future<bool> isLogged() async {
    try {
      SharedPreferences sharedUser = await SharedPreferences.getInstance();

      if (sharedUser.getString('user') != null) {
        Map userMap = jsonDecode(sharedUser.getString('user')!);
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
