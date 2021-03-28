import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrift_nep/components/user_profile/user.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/constants/urls.dart';

class AllUserProvider extends ChangeNotifier {

  List<Users> users = [];
  List<Users> get allusers => UnmodifiableListView(users);

  Future<void> fetchUser() async {
    var url = '$ALLUSERS_URL';
    var response = await http.get(url);
    print (response);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      result.forEach((p) {
        var user = Users.fromJson(p);
        users.add(user);
        // name = user.name;
        // phoneNumber= user.phoneNumber;
        // status = user.status.toString();
      });
    }


    // notifyListeners();
  }
}
