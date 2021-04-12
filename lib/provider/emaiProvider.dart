import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrift_nep/components/user_profile/user.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/constants/urls.dart';

class EmailProvider extends ChangeNotifier {

 // List<Users> users = [];
  String id="";
  String name = "";
  String phoneNumber ="";
  String _email = '';
  String status = "";
  String email() => _email;
   String _name ="";
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    _email = prefs.getString('email') ?? '';
    fetchUser();
    //return email = await getValue() ?? "";
    //return email;
  }

  Future<void> fetchUser() async {
    var url = '$FETCHUSER_URL?user=$_email';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      result.forEach((p) {
        var user = Users.fromJson(p);
        name = user.name;
        phoneNumber= user.phoneNumber;
        status = user.status.toString();
        id = user.userId.toString();

      });
    }

   // notifyListeners();
  }
}
