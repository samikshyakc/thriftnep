import 'package:flutter/material.dart';
import 'package:thrift_nep/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  String hint;
  bool issecured;
  var controller;
  var suffixicon;
  var icon;
  var validator;
  var textInputAction;
  var keyboardType;

  CustomTextField(
      {this.hint,
      this.issecured,
      this.controller,
      this.suffixicon,
      this.icon,
      this.validator,
      this.textInputAction,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
        //  padding: new EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        //width: 250,   height: 50,   margin: new EdgeInsets.fromLTRB(20, 20, 20, 210),   padding: new EdgeInsets.fromLTRB(8, 8, 8, 8),
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: TextFormField(
          validator: validator,

          textInputAction: textInputAction,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: issecured,
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
             errorStyle: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.bold
             ),
              icon: icon,
              suffixIcon: suffixicon,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              filled: true,
              hoverColor: Colors.white70,
              focusColor: Colors.transparent,
              fillColor: Colors.white60,
              // fillColor: Color.fromRGBO(39, 185, 216, 1.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryLightColor),
                borderRadius: BorderRadius.circular(15),
              )),
        ));
  }
}
