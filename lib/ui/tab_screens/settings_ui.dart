import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jvdream/resources/store_preference.dart';
import 'package:jvdream/ui/auth_screens/initial_ui.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({super.key});

  @override
  State<SettingsUI> createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> with StorePreferneceData {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Settings"),
              Spacer(),
              TextButton(
                  onPressed: () {
                    _doOpenPage(context);
                  },
                  child: Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }

  void _doOpenPage(BuildContext contextMain) async {
    removeUserFromPreference();
    // Navigator.of(context, rootNavigator: true).pop().;

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => InitialUI()),
        (route) => false);

    // Navigator.pushAndRemoveUntil(contextMain,
    //     MaterialPageRoute(builder: (context) {
    //   return InitialUI();
    // }), ModalRoute.withName('/'));
  }
}