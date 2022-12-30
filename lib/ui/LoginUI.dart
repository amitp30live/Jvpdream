import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common_widgets/common_style.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double scrnWidth = MediaQuery.of(context).size.width;
    double scrnHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,
        title: Text(
          "LOGIN",
          //  style: TextStyle(""),
        ),
        backgroundColor: Colors.black87,
      )
      // title: Text(
      //   "Login",
      //   style: TextStyle(color: Colors.black),
      // ),
      // backgroundColor: Colors.white,
      ,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  topLogo(),
            // Container(
            //   height: 30,
            // ),
            // _backIcon(context),
            // Container(
            //   height: 10,
            // ),
            CommonWidgets.appIcon(scrnWidth * 0.35),
            Container(
              height: 30,
            ),
            // _textLogin(),
            // Container(
            //   height: 30,
            // ),
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

  Widget _backIcon(BuildContext context) {
    return IconButton(
        alignment: Alignment.topLeft,
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop());
  }

  Widget _textLogin() {
    return const Text("LOGIN",
        style: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            height: 1.3,
            color: Colors.black //You can set your custom height here
            ));
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
          print(value.isValidEmail());
        },
        controller: emailController,
        decoration: const InputDecoration(
          hintText: "Email",
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
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
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

  _btnLoginPressed() {
    print("btn Login Pressed");
  }

  _btnFogotoPasswordPressed() {
    print("btn forgot password Pressed");
  }

  Widget btnSignupWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?"),
          TextButton(
            child: Text('Get Started Now'),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.black, // foreground
            ),
            onPressed: () {
              //  Navigator.push(context, MaterialPageRoute(builder: (context) => ));
            },
          ),
        ],
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
