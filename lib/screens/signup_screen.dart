import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/widgets/customTextField.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';
import 'package:thrift_nep/utils/validator.dart';

class SignupScreen extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<SignupScreen> with ValidationMixin {
  final _globalKeyScaffold = GlobalKey<ScaffoldState>();
  bool _obscurePassword = true;
  bool _obscureConfirmpassword = true;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordconfirmController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  var name = '';
  var email = '';
  var password = '';
  var passwordConfirm = '';
  var phoneNumber ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKeyScaffold,
      body: Container(
        decoration: BoxDecoration(
          image:
          DecorationImage(image: AssetImage('1.png'), fit: BoxFit.fill),
          gradient: LinearGradient(
              colors: [kPrimaryColor, kAppbar],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Form(
          child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ),
                SizedBox(
                  height: 85,
                ),
                signupform(),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: ButtonTheme(
                      buttonColor: Colors.white70,
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      child: RaisedButton(
                        onPressed: () {
                          _validateInputs();
                        },
                        child: Text(
                          'Create',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'OR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have an Accout ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
        ),
      ),
    );
  }

  Widget signupform() {
    return Form(
        key: _formKey,
        autovalidateMode: _autoValidate,
        child: Column(
          children: [
            CustomTextField(
              controller: usernameController,
              validator: validateName,
              hint: '  Full Name',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              issecured: false,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: emailController,
              hint: '  Email',
              validator: validateEmail,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              issecured: false,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: phoneController,
              hint: '  Phone Number',
              validator: validateMobile,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              issecured: false,
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: passwordController,
              hint: '  Password',
              validator: validatePassword,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              issecured: _obscurePassword,
              suffixicon: IconButton(
                icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            CustomTextField(
              controller: passwordconfirmController,
              hint: ' Confirm Password',
              // validator: validatePassword,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              validator: (String value) {
                if (value.length == 0) {
                  return 'Password can\'t be empty';
                } else if (value.length < 6) {
                  return 'Password must be longer than 6 characters';
                } else if (value != passwordController.text) {
                  return 'Enter matching password';
                }
                return null;
              },
              issecured: _obscureConfirmpassword,
              suffixicon: IconButton(
                icon: Icon(_obscureConfirmpassword
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureConfirmpassword = !_obscureConfirmpassword;
                  });
                },
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
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordconfirmController.dispose();
    super.dispose();
  }

  void register() async {
    name = usernameController.text;
    email = emailController.text;
    password = passwordController.text;
    passwordConfirm = passwordconfirmController.text;
    phoneNumber = phoneController.text;
    onLoading(context);
    var url = '$REGISTER_URL?name=$name&email=$email&phoneNumber=$phoneNumber&password=$password';
    var response = await http.get(url);
    Navigator.pop(context);
    // print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.body.contains("Registration Successful")) {
      saveEmail();
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      _showSnackBar('Registration failed! ');
    }
  }

  void _showSnackBar(String message) {
    final _snackBar = SnackBar(content: Text(message));
    _globalKeyScaffold.currentState.showSnackBar(_snackBar);
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      register();
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }
}
