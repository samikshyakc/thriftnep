import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailProvider extends ChangeNotifier {
  String _email = '';

  String email() => _email;

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    _email = prefs.getString('email') ?? '';

    //return email = await getValue() ?? "";
    //return email;
  }
}
