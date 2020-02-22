import 'dart:convert';

import 'package:random_user/helper/network_util.dart';
import 'package:random_user/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/io_client.dart';

class UserProvider with ChangeNotifier {
  User _user;

  IOClient _ioClient;

  get user => _user;

  set ioClient(ioClient) => this._ioClient = ioClient;

  Future<void> fetchNewUser() async {
    var url = '${NetworkUtil.SERVER_URL}${NetworkUtil.USER_SEGMENT}';

    try {
      final response = await _ioClient.get(url);

      print("fetchNewUser: Response--->${response?.statusCode}, ${response?.body}");

      if (response != null &&
          response.statusCode >= 200 &&
          response.statusCode < 300) {
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
      notifyListeners();
      throw Exception("Invalid response code or data.");
    } catch (error) {
      print("fetchNewUser: Exception--->$error");
      throw (error);
    }
  }
}
