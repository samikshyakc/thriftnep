import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/utils/validator.dart';
import 'package:thrift_nep/widgets/customTextField.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<LoginScreen> with ValidationMixin {
  final _globalKeyScaffold = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  bool _obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var email = '';
  var password = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKeyScaffold,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('1.png'), fit: BoxFit.fill),
            gradient: LinearGradient(
                 colors: [kPrimaryColor, kPrimaryLightColor],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
          child: Center(
            child: Form(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(
                      ' Sign in with your account',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  loginForm(),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 25.0, top: 8.0),
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35, right: 35),
                      child: ButtonTheme(
                          buttonColor: Colors.white,
                          minWidth: MediaQuery.of(context).size.width,
                          height: 55,
                          child: RaisedButton(
                            onPressed: () {
                              _validateInputs();
                            },
                            child: Text(
                              'Log in',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 22),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have an Accout ?",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, 'signup');
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Column(
          children: [
            CustomTextField(
              hint: '   Email',
              validator: validateEmail,
              controller: emailController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
              issecured: false,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: CustomTextField(
                hint: '   Password',
                validator: validatePassword,
                controller: passwordController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                issecured: _obscurePassword,
                suffixicon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
          ],
        ));
  }

  saveEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    email = emailController.text;
    password = passwordController.text;
    onLoading(context);
    var url = '$LOGIN_URL?email=$email&password=$password';
    var response = await http.get(url);
    Navigator.pop(context);
    //print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("Login Sucessful!!")) {
      saveEmail();
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      _showSnackBar('Login failed!');
    }
  }

  void _showSnackBar(String message) {
    final _snackBar = SnackBar(content: Text(message));
    _globalKeyScaffold.currentState.showSnackBar(_snackBar);
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      login();
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }
}
// void login() async {
//   email = emailController.text;
//   password = passwordController.text;
//   onLoading(context);
//   var url = '$LOGIN_URL?email=$email&password=$password';
//   var response = await http.get(url);
//   Navigator.pop(context);
//   //print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
//   if (response.body.contains("Login Sucessful!!")) {
//     saveEmail();
//     Navigator.pushReplacementNamed(context, 'home');
//   } else {
//     _showSnackBar('Login failed!');
//   }
// }
