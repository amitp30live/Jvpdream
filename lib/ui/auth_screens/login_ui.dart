import 'package:flutter/material.dart';
import 'package:jvdream/blocs/auth_bloc.dart';
import 'package:jvdream/models/user_model.dart';

import 'package:jvdream/ui/auth_screens/signup_ui.dart';
import 'package:jvdream/ui/base/base_ui.dart';
import 'package:jvdream/ui/tab_screens/tabbar.dart';
import 'package:jvdream/utils/extension/common_widgets/common_style.dart';
import 'package:jvdream/utils/extension/validation.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}
// ignore: prefer_const_constructors

class _LoginUIState extends BaseStatefulState<LoginUI> with ValidationMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var loginData = <String, String>{};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenBlocData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrnWidth = MediaQuery.of(context).size.width;
    //double scrnHeight = MediaQuery.of(context).size.height;
    contextMain = context;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,
        title: const Text(
          "LOGIN",
          //  style: TextStyle(""),
        ),
        backgroundColor: Colors.black87,
      ),
      body: isApiCallInProgress
          ? Center(
              child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.appIcon(scrnWidth * 0.35),
                    Container(
                      height: 30,
                    ),
                    emailTextFieldWidget(),
                    Container(height: 20),
                    passwordTextFieldWidget(),
                    Container(height: 20),
                    _btnForgotPassword(context),
                    Container(
                      height: 40,
                    ),
                    ThemeButton.btnRound("LOGIN", _btnLoginPressed),
                    Container(
                      height: 40,
                    ),
                    btnSignupWidget(),
                    Container(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _btnForgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: flatButtonStyle,
          onPressed: () {},
          child: Text('Forgot Password?'),
        ),
      ],
    );
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: Colors.black87,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  Widget emailTextFieldWidget() {
    return Container(
      color: Colors.grey[100],
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        onChanged: (value) {
          loginData["email"] = value;
        },
        controller: emailController,
        decoration: const InputDecoration(
          hintText: "Email",
          focusColor: Colors.black,
          hintStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          //border: OutlineInputBorder(),
          labelText: 'Email',
        ),
        validator:
            //validateEmail
            (value) {
          if (value!.isEmpty) {
            return 'Please enter a valid email address';
          }
          if (!value.contains('@')) {
            return 'Email is invalid, must contain @';
          }
          return null;
        },
      ),
    );
  }

  Widget passwordTextFieldWidget() {
    return Container(
      color: Colors.grey[100],
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        onChanged: (value) {
          loginData["password"] = value;
        },
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Password",
          hintStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          // border: OutlineInputBorder(),
          labelText: 'Password',
        ),
        validator: validatePassword

        /*(value) {
          if (value!.isEmpty) {
            return 'Please enter a password';
          }
          if (value.length < 5) {
            return 'Password is invalid, must contain 6 characters';
          }
          return null;
        }*/
        ,
      ),
    );
  }

  _btnLoginPressed() async {
    /*  if (loginData["email"] == null) {
      return SnackbarClass.createSnackBar(
          'Please enter email address', contextMain);
    }
    if (loginData["email"] != null) {
      String email = loginData["email"]!;
      if (!email.isValidEmail) {
        return SnackbarClass.createSnackBar(
            'Please enter valid email', contextMain);
      }
    }

    if (loginData["password"] == null) {
      return SnackbarClass.createSnackBar('Enter password', contextMain);
    }
    if (loginData["password"] != null) {
      String password = loginData["password"]!;
      if (password.length < 5) {
        return SnackbarClass.createSnackBar(
            'Enter valid password more than 5 characters', contextMain);
      }
    }
    */

    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        if (mounted) {
          if (!isConnectionAvailable) {
            SnackbarClass.createSnackBar(
                "No Internet connection available.", contextMain);
            return;
          }
          setState(() {
            isApiCallInProgress = true;
          });
          authBloc.doLogin(loginData);
        }
      }
    }
  }

  Map<String, dynamic> modelFromObject(UserModel userthis) {
    var parsedJson = Map<String, dynamic>();
    parsedJson["firstName"] = userthis.firstName;
    parsedJson["lastName"] = userthis.lastName;
    parsedJson["email"] = userthis.email;
    parsedJson["phoneNo"] = userthis.phoneNo;
    parsedJson["_id"] = userthis.sid;
    parsedJson["friendList"] = userthis.friendList;
    parsedJson["accessToken"] = userthis.accessToken;
    parsedJson["refreshToken"] = userthis.refreshToken;
    return parsedJson;
  }

//mark: Listen
  _listenBlocData() {
    authBloc.streamUserInfo.listen((response) {
      // emailController.clear();
      // passwordController.clear();
      if (response.status == 200) {
        setState(() {
          isApiCallInProgress = false;

          Navigator.pushAndRemoveUntil(contextMain,
              MaterialPageRoute(builder: (context) {
            return TabbarPage();
          }), ModalRoute.withName('/'));
        });
      } else {
        print("Something went wronnggggg---");
        SnackbarClass.createSnackBar(response.message, contextMain);
        setState(() {
          isApiCallInProgress = false;
        });
      }
    });
  }

  Widget btnSignupWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?"),
        TextButton(
          child: Text('Get Started Now'),
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black, // foreground
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignupUI()));
          },
        ),
      ],
    );
  }
}
