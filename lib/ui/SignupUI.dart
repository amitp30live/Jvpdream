import 'package:flutter/material.dart';
import '../common_widgets/common_style.dart';
import '../ui/LoginUI.dart';

class SignupUI extends StatefulWidget {
  const SignupUI({super.key});

  @override
  State<SignupUI> createState() => _SignupUIState();
}

class _SignupUIState extends State<SignupUI> {
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double scrnWidth = MediaQuery.of(context).size.width;
    double scrnHeight = MediaQuery.of(context).size.height;
    double txtfldHeight = scrnWidth * .15;

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,
        title: Text(
          "SIGNUP",
          //  style: TextStyle(""),
        ),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  topLogo(),

            CommonWidgets.appIcon(scrnWidth * 0.35),
            Container(
              height: 10,
            ),

            aTextFieldWidget(firstnameController, "First Name", "First Name",
                false, txtfldHeight),
            Container(
              height: 8,
            ),
            aTextFieldWidget(lastnameController, "Last Name", "Last Name",
                false, txtfldHeight),
            Container(
              height: 8,
            ),
            aTextFieldWidget(
                emailController, "Email", "Email", false, txtfldHeight),
            Container(
              height: 8,
            ),
            aTextFieldWidget(
                passwordController, "Password", "Password", true, txtfldHeight),
            Container(
              height: 8,
            ),
            aTextFieldWidget(confirmPasswordController, "Confirm Password",
                "Confirm password", true, txtfldHeight),
            Container(
              height: 8,
            ),
            aTextFieldWidget(
                phoneNoController, "Phone No", "Phone No", false, txtfldHeight),

            //  emailTextFieldWidget(),
            Container(height: 20),

            ThemeButton.btnRound("Create Account", _btnCreatePressed),
            Container(
              height: 16,
            ),
            btnSignupWidget(),
            Container(
              height: 16,
            ),
          ],
        ),
      ),
    );
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

  Widget aTextFieldWidget(TextEditingController controller, String name,
      String placeHolderText, bool isSecured, double txtFldheight) {
    return Container(
      height: txtFldheight,
      color: Colors.grey[100],
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        onChanged: (value) {
          print(value.isValidEmail());
        },
        obscureText: isSecured,
        controller: controller,
        decoration: InputDecoration(
          hintText: name,
          hintStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
          //border: OutlineInputBorder(),
          labelText: placeHolderText,
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

  _btnCreatePressed() {
    print("btn Create Pressed");
  }

  Widget btnSignupWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account.!"),
          TextButton(
            child: Text('Login'),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.black, // foreground
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
