import 'dart:convert';

import 'package:random_user/helper/network_util.dart';
import 'package:random_user/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';

/// Holds and provide user data from randomuser.me api
class UserProvider with ChangeNotifier {

  // Current user object
  User _user;

  // IOClient to make http requests
  IOClient _ioClient;

  get user => _user;

  // Will be used by ChangeNotifierProxyProvider to set the IOClient
  set ioClient(ioClient) => this._ioClient = ioClient;

  /// Fetch new user data from randomuser.me api
  Future<void> fetchNewUser() async {
    var url = '${NetworkUtil.SERVER_URL}${NetworkUtil.USER_SEGMENT}';

    try {
      // Make a get request
      final response = await _ioClient.get(url);

      print(
          "fetchNewUser: Response--->${response?.statusCode}, ${response?.body}");

      if (response != null &&
          response.statusCode >= 200 &&
          response.statusCode < 300) {
        // Convert json response to Map
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse != null) {
          var results = jsonResponse["results"] as Iterable;
          if (results.length > 0) {
            _user = User.fromJson(results.elementAt(0));
            notifyListeners();
            return;
          }
        }
      }

      // Notify all the consumers
      notifyListeners();
      throw Exception("Invalid response code or data.");
    } catch (error) {
      print("fetchNewUser: Exception--->$error");
      throw (error);
    }
  }
}
