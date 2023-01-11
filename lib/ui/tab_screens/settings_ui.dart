// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/store_preference.dart';
import 'package:jvdream/ui/auth_screens/initial_ui.dart';
import 'package:jvdream/ui/base/base_ui.dart';
import 'package:jvdream/utils/common_widgets/common_style.dart';

void main(List<String> args) {
  runApp(SettingsUI());
}

class SettingsUI extends StatefulWidget {
  const SettingsUI({super.key});

  @override
  State<SettingsUI> createState() => _SettingsUIState();
}

class _SettingsUIState extends BaseStatefulState<SettingsUI>
    with StorePreferneceData {
  late UserModel user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareData();
  }

  prepareData() async {
    var usera = await auth.loggedUser();
    if (usera != null) {
      user = usera;
    }
  }

  @override
  Widget build(BuildContext context) {
    contextMain = context;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              toplayout(),
              const Spacer(),
              btnLogout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget toplayout() {
    return Row(children: [
      imgProfile(),
      Container(
        width: 6,
      ),
      nameDetails(user),
    ]);
  }

  Widget nameDetails(UserModel user) {
    var name = "${user.firstName}  ${user.lastName}";
    return CommonWidgets.textWidget(name);
  }

  Widget imgProfile() {
    // https://picsum.photos/200
    return Container(
      margin: EdgeInsets.all(2),
      child: CircleAvatar(
        radius: 56,
        backgroundColor: Colors.grey[350],
        child: Padding(
          padding: const EdgeInsets.all(2), // Border radius
          child: ClipOval(child: Image.network('https://picsum.photos/200')),
        ),
      ),
    );
  }

  Widget btnLogout() {
    return TextButton(
        onPressed: () {
          _doOpenPage(context);
        },
        child: Text("Logout"));
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
