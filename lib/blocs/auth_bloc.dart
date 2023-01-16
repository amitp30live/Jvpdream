import 'package:flutter/foundation.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

enum SignupEnum { firstName, lastName, email, password, password2, phoneNo }

class AuthBloc {
  final authRepo = AuthRepository();

  final _loginFetcher = PublishSubject<LoginResponse>();
  Stream<LoginResponse> get streamUserInfo => _loginFetcher.stream;

  doLogin(Map<String, String> loginData) async {
    var data = await authRepo.doLogin(loginData);

    return _loginFetcher.sink.add(data);
  }

  doSignup(Map<String, String> signupData) async {
    var data = await authRepo.doSignup(signupData);

    return _loginFetcher.sink.add(data);
  }
}

final authBloc = AuthBloc();
