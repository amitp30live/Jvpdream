// ignore_for_file: prefer_const_constructors

import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/store_preference.dart';
import 'package:jvdream/ui/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:jvdream/utils/common_widgets/common_style.dart';

class OtherUserProfile extends StatefulWidget {
  const OtherUserProfile({super.key});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends BaseStatefulState<OtherUserProfile> {
  bool isFriend = false;
  //Show Send request button if isFriend = false
  //Show Remove friend button if isFriend = false

  bool isSendRequest = false;
  //Show Cancel request button if isSendRequest = false

  bool receivedRequest = false;
  //Show Accept/Decline buttons if receivedRequest = false

  @override
  Widget build(BuildContext context) {
    contextMain = context;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(padding: EdgeInsets.zero, children: [
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
            Container(
              height: 18,
            ),
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
            height: 4,
          ),
          CommonWidgets.textWidget("Mob no: ${user.phoneNo}",
              weight: FontWeight.normal),
          Container(
            height: 4,
          ),
          CommonWidgets.textWidget("Email: ${user.email}",
              weight: FontWeight.normal),
          Container(
            height: 4,
          ),
          TextButton(
            onPressed: () {
              //Update UI and Send request
            },
            child: Text("Send Request"),
          )
          // TextButton Text("Send Request"))
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
}
