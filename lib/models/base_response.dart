import 'package:connectivity_plus/connectivity_plus.dart';

class BaseDataRes {
  late int status;
  late String message;

  BaseDataRes({required this.status, required this.message});
}

mixin CheckInternetConnection {
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print("MOBILE INTERNET Connection");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("WIFI INTERNET Connection");
      return true;
      // I am connected to a wifi network.
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      print("ethernet INTERNET Connection");
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      print("NO INTERNET Connection");
      return false;
    }
    return true;
  }
}
