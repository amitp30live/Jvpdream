// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

        // appBar: AppBar(
        //   title: Text("Settings"),
        //   backgroundColor: Colors.black,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(padding: EdgeInsets.zero, children: [
            // Column(
            //   children: [

            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imgProfile(),
                  Container(
                    width: 8,
                  ),
                  columnNameDetails(Auth.authUser),
                ]),
            // ListTile(
            //   title: Text("Update Profille"),
            //   style: ListTileStyle.drawer,
            // ),
            Container(
              height: 18,
            ),
            // Card(
            //   shape: RoundedRectangleBorder(
            //     side: BorderSide(
            //       color: Colors.black54,
            //     ),
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            //   child: ListTile(
            //     title: CommonWidgets.textWidget("Update Profile"),
            //     leading: Icon(Icons.person),
            //   ),
            // ),

            ListTile(
              dense: true,
              title: CommonWidgets.textWidget("Update Profile"),
              leading: Icon(Icons.person),
              onTap: () => {print("Update profile pressed")},
            ),
            Divider(),

            ListTile(
              dense: true,
              title: CommonWidgets.textWidget("Change password"),
              leading: Icon(Icons.password),
              onTap: () => {print("Change password pressed")},
            ),
            Divider(),

            ListTile(
              dense: true,
              title: CommonWidgets.textWidget("Notifications Settings"),
              leading: Icon(Icons.notifications),
              onTap: () => {print("Notifications Settings pressed")},
            ),
            Divider(),

            ListTile(
              dense: true,
              title: CommonWidgets.textWidget("Terms & condition"),
              leading: Icon(Icons.notes),
              onTap: () => {print("Terms and condition pressed")},
            ),
            Divider(),
            ListTile(
              dense: true,
              title: CommonWidgets.textWidget("Privacy & Policy"),
              leading: Icon(Icons.privacy_tip),
              onTap: () => {print("Privacy & Policy pressed")},
            ),
            Divider(),
            // ListTile(
            //   title: Text("Terms and notes"),
            // ),
            // ListTile(
            //   title: Text("Privacy policy"),
            // ),
            // ListTile(
            //   title: Text("Logout"),
            // ),

            Card(child: btnLogout()),
            //   ],
            // ),
          ]),
        ),
      ),
    );
  }

  Widget columnNameDetails(UserModel user) {
    var name = "${user.firstName}  ${user.lastName}";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
          ),
          CommonWidgets.textWidget(name),
          Container(
            height: 6,
          ),
          CommonWidgets.textWidget("Mob no: ${user.phoneNo}",
              weight: FontWeight.normal),
          Container(
            height: 6,
          ),
          CommonWidgets.textWidget("Email: ${user.email}",
              weight: FontWeight.normal),
        ],
      ),
    );
  }

  Widget imgProfile() {
    // https://picsum.photos/200
    return CircleAvatar(
      radius: 56,
      backgroundColor: Colors.grey[350],
      child: Padding(
        padding: const EdgeInsets.all(2), // Border radius
        child: ClipOval(child: Image.network('https://picsum.photos/200')),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop("Discard");

        // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        _doOpenPage(contextMain);
        // Navigator.of(context).pop(); // dismiss dialog
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure want to logout?"),
      actions: [continueButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget btnLogout() {
    return TextButton(
        onPressed: () {
          //_doOpenPage(context);
          showAlertDialog(contextMain);
        },
        child: CommonWidgets.textWidget("Logout"));
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
