import 'package:flutter/foundation.dart';
import 'package:jvdream/models/user_model.dart';
import 'package:jvdream/resources/auth_repository.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  final authRepo = AuthRepository();

  final _loginFetcher = PublishSubject<UserModel>();
  Stream<UserModel> get userInfo => _loginFetcher.stream;

  doLogin(Map<String, String> loginData) async {
    UserModel userModel = await authRepo.doLogin(loginData);
    _loginFetcher.sink.add(userModel);
  }
}

final authBloc = AuthBloc();
