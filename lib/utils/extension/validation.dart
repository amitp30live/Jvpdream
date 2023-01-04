extension ExtentionValidator on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(r'^.{6,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}

mixin ValidationMixin {
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    RegExp regex = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Please enter email';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter a valid email address';
      } else {
        return null;
      }
    }
  }

  String? validatePhoneNmbr(String? value) {
    RegExp regex = RegExp(r"^[0-9]{10}$");

    if (value!.isEmpty) {
      return 'Please enter phone number';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter a valid phone number';
      } else {
        return null;
      }
    }
  }

  String? validateFirstName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter first name';
    } else {
      if (value.length <= 3) {
        return 'Enter enter first name more than 3 characters';
      } else {
        return null;
      }
    }
  }

  String? validateLastName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter last name';
    } else {
      if (value.length <= 1) {
        return 'Enter enter last name more than 1 character';
      } else {
        return null;
      }
    }
  }

  String? validatePassword(String? value) {
    //  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final regex = RegExp(r'^.{6}/pre>');

    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (value.length < 5) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }

    /*
  r'^
  (?=.*[A-Z])       // should contain at least one upper case
  (?=.*[a-z])       // should contain at least one lower case
  (?=.*?[0-9])      // should contain at least one digit
  (?=.*?[!@#\$&*~]) // should contain at least one Special character
  .{8,}             // Must be at least 8 characters in length  
$
  */
  }
}
