import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jvdream/blocs/auth_bloc.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/ui/HomeUI.dart';
import 'package:jvdream/ui/SignupUI.dart';
import '../common_widgets/common_style.dart';
import '../utils/extension/validation.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}
// ignore: prefer_const_constructors

class _LoginUIState extends State<LoginUI> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var loginData = Map<String, String>();
  var isApiCallInProgress = false;
  late BuildContext contextMain;
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
    double scrnHeight = MediaQuery.of(context).size.height;
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
              padding: EdgeInsets.all(25),
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
      child: TextField(
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
      ),
    );
  }

  Widget passwordTextFieldWidget() {
    return Container(
      color: Colors.grey[100],
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
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
      ),
    );
  }

  _btnLoginPressed() async {
    if (loginData["email"] == null) {
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

    setState(() {
      isApiCallInProgress = true;
    });
    authBloc.doLogin(loginData);
  }

//mark: Listen
  _listenBlocData() {
    authBloc.streamUserInfo.listen((response) async {
      // emailController.clear();
      // passwordController.clear();
      if (response.status == 200) {
        setState(() {
          isApiCallInProgress = false;

          // var data =
          //          StoreUserInPreference.storeUser(response.user.toString());
          //     print(data);
          //     var userdetails = await StoreUserInPreference.fetchUser();
          //     print(userdetails);

          Navigator.push(
            contextMain,
            MaterialPageRoute(builder: (context) {
              return HomeUI();
            }),
          );
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
