// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:jvdream/blocs/friendshp_bloc.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/store_preference.dart';
import 'package:jvdream/ui/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:jvdream/utils/common_widgets/common_style.dart';

// ignore: must_be_immutable
class OtherUserProfile extends StatefulWidget {
  UserModel otherUser;

  OtherUserProfile({super.key, required this.otherUser});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends BaseStatefulState<OtherUserProfile> {
  var currentStatus = "";
  @override
  void initState() {
    super.initState();
    contextMain = context;
    listenData();
    apiCall();
  }

  apiCall() {
    var dict = <String, String>{};
    dict["userId"] = Auth.authUser.sid;
    dict["otherUserId"] = widget.otherUser.sid;
    friendshpBloc.getFriendStatus(dict);
  }

  listenData() {
    friendshpBloc.streamFrndStatusInfo.listen((event) {
      print(event);
      log(event.reqStatus);
      if (mounted) {
        setState(() {
          currentStatus = event.reqStatus.toLowerCase();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    contextMain = context;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: _onBackPressed),
          title: Text('Profile'),
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
                  columnNameDetails(widget.otherUser),
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
          CommonWidgets.textWidget("Email: ${user.email}",
              weight: FontWeight.normal),
          Container(
            height: 4,
          ),
          showButtonsAsPerCurrentStatus(),
          // TextButton Text("Send Request"))
        ],
      ),
    );
  }

  Widget showButtonsAsPerCurrentStatus() {
    if (currentStatus == "notfriends") {
      return Row(children: [
        ElevatedButton(
          onPressed: () {
            //Update UI and Send request
            print("tapped on send friend request ");
          },
          style: getStyle(),
          child: Text("Send Request"),
        ),
      ]);
    } else if (currentStatus == "waitorcancelrequest") {
      return Row(children: [
        ElevatedButton(
          onPressed: () {
            //Update UI and Send request
            print("tapped on cancel friend request ");
          },
          style: getStyle(),
          child: Text("Cancel Request"),
        ),
      ]);
    } else if (currentStatus == "friends") {
      return Row(children: [
        ElevatedButton(
          onPressed: () {
            //Update UI and Send request
            print("tapped on remove friend");
          },
          style: getStyle(),
          child: Text("Remove Friend"),
        ),
      ]);
    } else if (currentStatus == "respondtorequest") {
      return Row(children: [
        ElevatedButton(
          onPressed: () {
            //Update UI and Send request
            print("Accept request");
          },
          style: getStyle(),
          child: Text("Accept"),
        ),
        Container(
          width: 5,
        ),
        ElevatedButton(
          onPressed: () {
            //Update UI and Send request
            print("Decline request");
          },
          style: getStyle(),
          child: Text("Decline"),
        ),
      ]);
    }
    return Text("...");
  }

  ButtonStyle getStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black), // background
        // foregroundColor: MaterialStateProperty.all(Colors.yellow), // foreground
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.white))));
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

  void _onBackPressed() {
    Navigator.of(contextMain).pop();
  }
}
