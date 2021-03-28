import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/Users/user_widget.dart';
import 'package:thrift_nep/components/user_profile/user.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/allUserProvider.dart';


class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  List<Users> user = [];
  //int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    user =
        Provider.of<AllUserProvider>(context, listen: false).allusers;
    // print(totalPrice);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'Users',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [],
        ),
        body: SingleChildScrollView(
          //crossAxisAlignment: CrossAxisAlignment.start,

          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: user.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return UsersWidget(user[index]);
              }),
        ),

      ),
    );
  }
}
