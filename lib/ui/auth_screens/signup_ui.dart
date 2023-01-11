// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jvdream/blocs/auth_bloc.dart';
import 'package:jvdream/ui/base/base_ui.dart';
import 'package:jvdream/ui/tab_screens/tabbar.dart';
import 'package:jvdream/utils/common_widgets/common_style.dart';
import 'package:jvdream/utils/extension/validation.dart';
import 'login_ui.dart';

class SignupUI extends StatefulWidget {
  const SignupUI({super.key});

  @override
  State<SignupUI> createState() => _SignupUIState();
}

class _SignupUIState extends BaseStatefulState<SignupUI> with ValidationMixin {
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNoController = TextEditingController();

  var signupData = <String, String>{};
  @override
  void initState() {
    super.initState();
    _listenBlocData();
  }

  @override
  Widget build(BuildContext context) {
    double scrnWidth = MediaQuery.of(context).size.width;
    contextMain = context;

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,
        title: Text(
          "SIGNUP",
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
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  topLogo(),

                    CommonWidgets.appIcon(scrnWidth * 0.35),
                    Container(
                      height: 10,
                    ),

                    aTextFieldWidget(
                        firstnameController, "First Name", "First Name", false),
                    Container(
                      height: 8,
                    ),
                    aTextFieldWidget(
                        lastnameController, "Last Name", "Last Name", false),
                    Container(
                      height: 8,
                    ),
                    aTextFieldWidget(emailController, "Email", "Email", false),
                    Container(
                      height: 8,
                    ),
                    aTextFieldWidget(
                        passwordController, "Password", "Password", true),
                    Container(
                      height: 8,
                    ),
                    aTextFieldWidget(confirmPasswordController,
                        "Confirm Password", "Confirm password", true),
                    Container(
                      height: 8,
                    ),
                    aTextFieldWidget(
                        phoneNoController, "Phone No", "Phone No", false),

                    //  emailTextFieldWidget(),
                    Container(height: 20),

                    ThemeButton.btnRound("Create Account", _btnCreatePressed),
                    Container(
                      height: 16,
                    ),
                    alreadyHaveAccountWidget(),
                    Container(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
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

  Widget aTextFieldWidget(TextEditingController controller, String name,
      String placeHolderText, bool isSecured) {
    return Container(
      //height: txtFldheight,
      color: Colors.grey[100],
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        onChanged: (value) {
          //print(value.isValidEmail());
          controllerForUpdatedata(controller, value);
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
        validator: (value) {
          // SampleEnum.second
          return validateErrorMsg(controller, value);
        },
      ),
    );
  }

/*
firstName:Amit
lastName:p
email:amitjv@gmail.com
//company:Ap info
phoneNo:8888899977
password:amit@1234
password2:amit@1234
*/
  controllerForUpdatedata(TextEditingController controller, String value) {
    if (controller == firstnameController) {
      signupData["firstName"] = value;
    } else if (controller == lastnameController) {
      signupData["lastName"] = value;
    } else if (controller == emailController) {
      signupData["email"] = value;
    } else if (controller == passwordController) {
      signupData["password"] = value;
    } else if (controller == phoneNoController) {
      signupData["phoneNo"] = value;
    } else if (controller == confirmPasswordController) {
      signupData["password2"] = value;
    }
    print(signupData);
  }

  validateErrorMsg(TextEditingController controller, String? value) {
    if (controller == firstnameController) {
      return validateFirstName(value);
    } else if (controller == lastnameController) {
      return validateLastName(value);
    } else if (controller == emailController) {
      return validateEmail(value);
    } else if (controller == passwordController) {
      return validatePassword(value);
    } else if (controller == phoneNoController) {
      return validatePhoneNmbr(value);
    } else if (controller == confirmPasswordController) {
      var pass = validatePassword(value);
      if (pass != null) {
        if (signupData["password"] != signupData["password2"]) {
          return 'Password and confirm password not matched';
        }
      }
      return pass;
    }
  }

  _btnCreatePressed() {
    print("btn Create Pressed");

    // var showSnacbarText = "";
    // for (var z in signupData.keys) {
    //   final SignupEnum nameEnum =
    //       SignupEnum.values.byName(z); // SampleEnum.second
    //   showSnacbarText = getValidationError(nameEnum);
    //   print(showSnacbarText);
    //   if (showSnacbarText.isNotEmpty) {
    //     SnackbarClass.createSnackBar(showSnacbarText, contextMain);
    //     return;
    //   }
    // }

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
          authBloc.doSignup(signupData);
        }
      }
    }
  }

  Widget alreadyHaveAccountWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account.!"),
        TextButton(
          child: Text('Login'),
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black, // foreground
          ),
          onPressed: () {
            Navigator.push(
              contextMain,
              MaterialPageRoute(builder: (context) {
                return LoginUI();
              }),
            );
          },
        ),
      ],
    );
  }

  _listenBlocData() {
    // signupData["firstName"] = "";
    // signupData["lastName"] = "";
    // signupData["email"] = "";
    // signupData["password"] = "";
    // signupData["phoneNo"] = "";
    // signupData["password2"] = "";

    authBloc.streamUserInfo.listen((response) async {
      if (response.status == 200) {
        // emailController.clear();
        // passwordController.clear();
        // firstnameController.clear();
        // lastnameController.clear();
        // confirmPasswordController.clear();
        // phoneNoController.clear();
        setState(() {
          isApiCallInProgress = false;
          SnackbarClass.createSnackBar(
              "Created account successfully..", contextMain);
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

  String getValidationError(SignupEnum n) {
    var msg = "";
    switch (n) {
      case SignupEnum.email:
        if (signupData["email"]!.isEmpty) {
          msg = 'Please enter email address';
          break;
        }
        if (signupData["email"] != null) {
          String email = signupData["email"]!;
          if (!email.isValidEmail) {
            msg = 'Please enter valid email';
            break;
          }
        }
        break;

      case SignupEnum.firstName:
        if (signupData["firstName"]!.isEmpty) {
          msg = 'Please enter first name';
          break;
        }
        break;

      case SignupEnum.lastName:
        if (signupData["lastName"] == null) {
          msg = 'Please enter last name';
          break;
        }
        break;

      case SignupEnum.phoneNo:
        if (signupData["phoneNo"]!.isEmpty) {
          msg = 'Please enter phone number ';
          break;
        }
        if (signupData["phoneNo"] != null) {
          String phoenNo = signupData["phoneNo"]!;
          if (phoenNo.length > 8) {
            msg = 'Enter valid phone number';
            break;
          }
        }
        break;
      case SignupEnum.password:
        if (signupData["password"]!.isEmpty) {
          msg = 'Please enter password';
          break;
        }
        if (signupData["password"] != null) {
          String password = signupData["password"]!;
          if (password.length < 6) {
            msg = 'Please enter more than 5 characters for password';
            break;
          }
        }
        break;
      case SignupEnum.password2:
        if (signupData["password2"]!.isEmpty) {
          msg = 'Please enter confirm password';
          break;
        }
        if (signupData["password2"] != null) {
          String password = signupData["password2"]!;
          if (password.length < 6) {
            msg = 'Please enter more than 5 characters for confirm password';
            break;
          }
        }

        if (signupData["password"] != signupData["password2"]) {
          msg = 'Password and confirm password not matched';
        }
        break;
      default:
        {
          break;
        }
    }
    return msg;
  }
}
