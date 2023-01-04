// ignore_for_file: public_member_api_docs
import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseStatefulState<T extends StatefulWidget> extends State<T> {
  var isApiCallInProgress = false;
  late BuildContext contextMain;
  final formKey = GlobalKey<FormState>();

  BaseStatefulState() {
    // Parent constructor
  }

  void baseMethod() {
    // Parent method
  }

  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isConnectionAvailable = false;
  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      isConnectionAvailable = false;
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectionStatus = result;
      print('Connection Status: ${connectionStatus.toString()}');
      if (connectionStatus == ConnectivityResult.none) {
        print("NO INTERNET Connection");
        isConnectionAvailable = false;
      } else {
        isConnectionAvailable = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity example app'),
      ),
      body: Center(
          child: Text('Connection Status: ${connectionStatus.toString()}')),
    );
  }
}
