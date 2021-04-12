import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/widgets/customTextField.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';

class MyAccount extends StatefulWidget {

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  final _globalKeyScaffold = GlobalKey<ScaffoldState>();
  String username="";
  String phoneNumber =  "";
  String emailAddress="";
  String newpassword = '';
  String password= '';
  String status = '';

  TextEditingController fullnameController ;
  TextEditingController phonenumberController ;
  TextEditingController emailController ;
  TextEditingController passwordController ;
  TextEditingController newpasswordController ;
  TextEditingController statusController ;

  bool _obscurePassword = true;

   String act = "active";

  List activity = ["active", "inactive"];

  @override
  Widget build(BuildContext context) {

    username =  Provider.of<EmailProvider>(context, listen: false).name;
    status =  Provider.of<EmailProvider>(context, listen: false).status;
    phoneNumber =Provider.of<EmailProvider>(context, listen: false).phoneNumber;
    emailAddress = Provider.of<EmailProvider>(context, listen: false).email();
    print(emailAddress);
    fullnameController = TextEditingController(text: "$username");
    phonenumberController = TextEditingController(text: "$phoneNumber");
    emailController = TextEditingController(text: "$emailAddress");
    statusController = TextEditingController(text: status == '1'?"active":'inactive');
    newpasswordController = TextEditingController();
    passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAppbar,
          title: Text("Edit Profile", style: TextStyle(color: Colors.white),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 35,bottom: 8,top: 10),
                  child: Text("Full Name"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 35),
                  child: TextField(
                       controller: fullnameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Colors.black)
                        ),
                        suffixIcon: Icon(Icons.account_circle_outlined),)


                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 35,bottom: 8),
                  child: Text("Phone Number"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 35),
                  child: TextField(
                    enabled: false,
                    controller: phonenumberController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Colors.black)
                      ),
                      suffixIcon: Icon(Icons.call),)
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 35,bottom: 8),
                  child: Text("Email Address"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 35),
                  child: TextField(
                    enabled: false,
                    controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        suffixIcon: Icon(Icons.call),)
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 35,bottom: 8),
                  child: Text("Enter new password"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 35),
                  child: TextField(
                    controller: newpasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.black)
                        ),
                      suffixIcon: IconButton(icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      )
                    ),
                  ),
                  ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 40,left: 35,bottom: 8),
                //   child: status == '1' ? Text("active") : Text("inactive"),
                // ),
                SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    child: Text("Update", style: TextStyle(fontSize: 20,color: Colors.white),),
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // title: Text("Are you sure?"),
                              //content: Text('Logout?'),
                              title: Text(' Enter your password'),

                              content:  CustomTextField(
                                hint: 'password',
                                // validator: validateEmail,
                                controller: passwordController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                issecured: true,
                              ),
                              actions: [
                                FlatButton(
                                  onPressed: () async {
                                    onLoading(context);
                                    verify();
                                    //   cashOnDelivery('COD');
                                    Navigator.pop(context);
                                    // Navigator.pushNamedAndRemoveUntil(
                                    //     context, 'confirmOrder', (route) => false);
                                  },
                                  child: Text('Confirm'),
                                ),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('NO')),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: kAppbar,
                        padding: EdgeInsets.all(8.0),
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
               Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("you can change your status"),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40,left: 35),
                  child: InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // title: Text("Are you sure?"),
                              //content: Text('Logout?'),
                              title: Text(' Enter your password'),

                              content:SizedBox(
                                height: 55,
                                width: 150,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0))),
                                  value:status== '1'? "active": "inactive",
                                  onChanged: (newValue) {
                                    setState(() {
                                      act = newValue;
                                    });
                                  },
                                  items: activity.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                              actions: [
                                FlatButton(
                                  onPressed: () async {

                                    onLoading(context);
                                    statusController.text = act;
                                    changeStatus();
                                    //verify();
                                    //   cashOnDelivery('COD');
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    // Navigator.pushNamedAndRemoveUntil(
                                    //     context, 'confirmOrder', (route) => false);
                                  },
                                  child: Text('Confirm'),
                                ),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('NO')),
                              ],
                            );
                          });
                    },
                    child: TextField(
                        enabled: false,
                        controller: statusController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.black)
                          ),
                          suffixIcon: Icon(Icons.lightbulb),),


                    ),
                  ),
                ),


              ],
            ),
          ),
        ),

      ),
    );
  }
  void verify() async {
    username = fullnameController.text;
    password = passwordController.text;
    newpassword = newpasswordController.text;
    String email = Provider.of<EmailProvider>(context, listen: false).email();
    onLoading(context);
    var url = '$VERIFIYUSER_URL?email=$email&password=$password';
    var response = await http.get(url);
    print('Response body: ${response.body}');
    if (response.body.contains("matched!!")) {
      var url2 = '$UPDATEUSER_URL?email=$email&name=$username&password=$newpassword';
      var response = await http.get(url2);
      if(response.body.contains("Updated")) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'home');
      }
      else{
        _showSnackBar("Update failed");
    }
    } else {
      _showSnackBar('incorrect password!');
    }
  }

  void changeStatus() async {
    act = statusController.text;
    String email = Provider.of<EmailProvider>(context, listen: false).email();
    onLoading(context);
    var url = '$CHANGESTATUS_URL?email=$email&status=$act';
    var response = await http.get(url);
    print('Response body: ${response.body}');
    if (response.body.contains("Updated")) {
      print("done");
      Navigator.pop(context);
      // Navigator.pushReplacementNamed(context, 'home');
    }
    else{
      print("Update failed");
      Navigator.pop(context);
    }
  }
  void _showSnackBar(String message) {
    final _snackBar = SnackBar(content: Text(message));
    _globalKeyScaffold.currentState.showSnackBar(_snackBar);
  }
}
