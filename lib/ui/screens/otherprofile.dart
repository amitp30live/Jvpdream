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
  OtherUserProfile({super.key, @required otherUser});
  late UserModel otherUser;

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends BaseStatefulState<OtherUserProfile> {
  //Show Send request button if isFriend = false
  //Show Remove friend button if isFriend = true
  var currentStatus = "";
  //Show Cancel request button if isSendRequest = true
  //Show Cancel request button if isSendRequest = true
  // late UserModel otherUser;

  //Show Accept/Decline buttons if receivedRequest = false
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenData();
  }

  apiCall() {
    var dict = <String, String>{};
    dict["requesterId"] = Auth.authUser.sid;
    dict["recipientId"] = widget.otherUser.sid;
    friendshpBloc.getFriendStatus(dict);
  }

  listenData() {
    friendshpBloc.streamFrndStatusInfo.listen((event) {
      print(event);
      log(event.reqStatus);
    });
  }

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
