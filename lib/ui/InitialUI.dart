// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jvdream/ui/BaseUI.dart';
import 'package:jvdream/ui/SignupUI.dart';
import '../ui/LoginUI.dart';

class InitialUI extends StatefulWidget {
  const InitialUI({super.key});

  @override
  State<InitialUI> createState() => _InitialUIState();
}

class _InitialUIState extends State<InitialUI> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg1.jpg"),
                fit: BoxFit.cover,
                opacity: 0.7,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.darken)),
          ),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //  topLogo(),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/images/apple.png',
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text("AN AMAZING WORLD,\nSTART EACH DAY WITH AMBITION.!",
                    style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                        color:
                            Colors.white //You can set your custom height here
                        )),

                const Spacer(),
                btnSignupButton("SIGNUP", context),
                const SizedBox(
                  height: 20,
                ),
                btnLoginButton("LOGIN", context),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  static Widget btnLoginButton(String text, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginUI()))
        },
        // ignore: sort_child_properties_last
        child: Text(text, style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22), // <-- Radius
            ),
            backgroundColor: Colors.black45),
      ),
    );
  }

  static Widget btnSignupButton(String text, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignupUI()))
        },
        child: Text(text, style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22), // <-- Radius
            ),
            backgroundColor: Colors.black45),
      ),
    );
  }

  _btnCreatePasswordPressed() {
    print("btn create password Pressed");
  }

  Widget topLogo() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Create Account'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
      ),
    );
  }
}
