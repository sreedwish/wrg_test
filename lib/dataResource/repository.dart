// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:white_rabbit_sreedwish/dataResource/hive_boxes.dart';
import 'package:white_rabbit_sreedwish/models/user.dart';
import 'package:white_rabbit_sreedwish/rest/api_client.dart';
import 'package:white_rabbit_sreedwish/rest/server_error.dart';
import 'package:white_rabbit_sreedwish/rest/server_response.dart';

class Repository {
  final Dio _dio = Dio();
  late ApiClient _apiClient;

  Repository() {
    _apiClient = ApiClient(_dio);
  }

  /// This is the user list getting method from server/local db.
  /// If no data in database, then loading from server. It then store
  /// to local database.
  Future<List<User>> getUsers(String? str) async {
    List<User> response = [];

    try {
      final box = HiveBoxes.getUsers();

      // Checking data in local db is empty
      if (box.isEmpty) {
        //Api call from server
        response = await _apiClient.getUsers();

        // Response is a user list.
        // It is iterating and element added to local db
        for (User u in response) {
          box.add(u);
        }
      } else {
        // data is in local db. so it loading from there
        response = box.values.toList();
      }
    } catch (error) {
      print(error.toString());
      response = [];
    }

    try {
      List<User> searchList = [];

      // The user is searching
      // the search string is comparing with user name and user email

      if (str != null) {
        for (var element in response) {
          // String comparison
          if (element.name!.toLowerCase().contains(str.toLowerCase()) ||
              element.email!.toLowerCase().contains(str.toLowerCase())) {
            //Adding the element to searched list
            searchList.add(element);
          }
        }

        // Search list should return in this case
        response.clear();
        response.addAll(searchList);
      }
    } catch (e) {
      print(e);
    }

    return response;
  }
}
