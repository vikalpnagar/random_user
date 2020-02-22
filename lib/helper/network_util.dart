import 'dart:io';

import 'package:connectivity/connectivity.dart';

class NetworkUtil {
  static const String SERVER_URL = "https://randomuser.me/";
  static const String USER_SEGMENT = "api";

  static Future<bool> checkNetworkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  static Future<bool> isActiveInternetAvailable() async {
    return checkNetworkConnectivity().then((available) async {
      if (available) {
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('Active Internet Connection Available');
            return true;
          }
        } on SocketException catch (_) {
          print('Active Internet Connection NOT Available');
        }
      }
      return false;
    });
  }
}
