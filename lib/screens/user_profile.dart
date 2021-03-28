import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/user_profile/account_screen.dart';
import 'package:thrift_nep/components/user_profile/user.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/provider/myProductProvider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  final Users user;
  @override
  Widget build(BuildContext context) {

    String email = Provider.of<EmailProvider>(context, listen: false).email();
    Provider.of<MyProductProvider>(context, listen: false).fetchmyProduct(email);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryLightColor,
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'Thrift Nep',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding:const EdgeInsets.all(8.0),),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/logo.jpg'),
                  ),

                  SizedBox(height: 20.0,),
                  Text(
                      'Prajwal KC'
                  ),
                  Padding(
                    padding:const EdgeInsets.all(4.0),),

                  Text("$email"),
                  Padding(
                    padding:const EdgeInsets.all(4.0),),


                  // ListView(
                  //   children: [
                  //     ListTile(
                  //
                  //     )
                  //   ],
                  // )
                ],
              ),

            ),
            Divider(
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  Card(
                    color: Colors.white70,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "home");
                      },
                      leading: Icon(Icons.home),
                      title: Text(
                        'Home',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white70,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, 'myProducts');
                      },
                      leading: Icon(Icons.wallet_giftcard_sharp),
                      title: Text(
                        'My Products',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text(
                        'My Orders',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white70,
                    child: ListTile(
                      onTap: ()
                      => Navigator.of(context).push(MaterialPageRoute(
                        //  here we are passing the value of the product to product details page
                          builder: (context) => MyAccount(
                                  // username: user.name,
                                  // email: user.email,
                          ))),

                      leading: Icon(Icons.account_circle),
                      title: Text(
                        'Edit Account',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white70,
                    child: ListTile(
                      onTap: () {
                        // _sendMail();
                      },
                      leading: Icon(Icons.feedback),
                      title: Text(
                        'Give Feedback',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
  // saveStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('status', status);
  // }


}


