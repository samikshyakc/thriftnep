import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/user_profile/user.dart';
import 'package:thrift_nep/constants/urls.dart';

class UserProvider extends ChangeNotifier {
  List<Users> users = [];

  List<Users> get allUsers => UnmodifiableListView(users); //yo bhaneko chai ProductProvider le matra aba productList lai change garna sakcha

  Future<void> fetchUser(String user) async {
    var url = '$FETCHUSER_URL?user=$user';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      result.forEach((p) {
        var user = Users.fromJson(p);
        users.add(user);
      });
    }

    notifyListeners();
  }


}




