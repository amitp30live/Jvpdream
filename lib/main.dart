import 'package:flutter/material.dart';
import 'package:jvdream/resources/storePreference.dart';
import 'package:jvdream/ui/InitialUI.dart';
import 'package:jvdream/ui/TabScreens/Tabbar.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isLogged = await auth.isLoggedUser();
  if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    // Use location.
    print("location permission allowed");
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


//Font Size Dynamic
//Each Height needs to b dynamic as per device height
