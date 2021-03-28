import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:thrift_nep/components/user_profile/user.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/allUserProvider.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';


class UsersWidget extends StatefulWidget {
  final Users users;

  UsersWidget(this.users);

  @override
  _UsersWidgetState createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  final _globalKeyScaffold = GlobalKey<ScaffoldState>();
  TextEditingController statusController ;

  String activeStatus = "active";

  List activity = ["active", "inactive"];
  @override
  Widget build(BuildContext context) {
    String act = widget.users.status;
    statusController = TextEditingController(text: act == '1'?"active":'inactive');
    // if(act =='1'){
    //   activeStatus = "active";
    // }else if(act == '0')
    //   {
    //     activeStatus = "inactive";
    //   }
    return InkWell(
      onTap: (){},
      // => Navigator.of(context).push(MaterialPageRoute(
      //   //  here we are passing the value of the product to product details page
      //     builder: (context) => ProductDetails(
      //       productId: widget.users.,
      //       productName:widget.users.productName,
      //       productPrice: widget.users.productPrice,
      //       // negotiable: product.negotiable,
      //       condition: widget.users.productCondition,
      //       usedfor: widget.users.usedFor,
      //       category: widget.users.category,
      //       productImages: widget.users.productImages,
      //       details: widget.users.description,
      //       seller: widget.users.seller,
      //
      //     ))),
      child: Card(
        child: Slidable(
          //   delegate: new SlidableDrawerDelegate(),
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            new IconSlideAction(
              caption: 'More',
              color: Colors.black45,
              icon: Icons.more_horiz,
              onTap: () {},
            ),
            new IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                onLoading(context);
                print("delete");
                // deleteCart();
                Navigator.pop(context);
              },
            ),
          ],
          child: Container(
            child: ListTile(
              // leading: Image(
              //   image: CachedNetworkImageProvider(widget.users.pr),
              //   width: 50.0,
              //   height: 100.0,
              // ),
              title: Text(widget.users.name),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Text("Email:"),
                      Text(
                        widget.users.email,
                        style: TextStyle(color: kAppbar),
                      ),
                    ],
                  ),

                  Padding(padding: const EdgeInsets.only(left: 20),),
                  //===product color section==
                  Row(
                    children: [
                      Text("Phone number"),
                      Text(
                        widget.users.phoneNumber,
                        style: TextStyle(color: kAppbar),
                      ),
                    ],
                  ),


                  //          ======Section for product price=====
                  Container(
                    alignment: Alignment.topLeft,
                    child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      //     widget.users.status == '1'? Text(
                    //   "$activeStatus",
                    //   style: TextStyle(
                    //       fontSize: 17.0,
                    //       color: kAppbar,
                    //       fontWeight: FontWeight.bold),
                    // ) :
                         SizedBox(width: 20,),
                          Container(
                            child: TextField(
                              enabled: false,
                              controller: statusController,
                              obscureText: false,
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(15.0),
                              //       borderSide: BorderSide(color: Colors.transparent)
                              //   ),
                              //  // suffixIcon: Icon(Icons.lightbulb),
                              //   ),


                            ),
                          ),
                          TextButton(
                              child: Text("Change status", style: TextStyle(decoration: TextDecoration.underline,),),
                            onPressed: (){
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
                                          value:widget.users.status == '1'? "active": "inactive",
                                          onChanged: (newValue) {
                                            setState(() {
                                              activeStatus = newValue;
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
                                          //  activeStatus = activeStatus;

                                            changeStatus();

                                            //verify();

                                           Navigator.pop(context);
                                           Navigator.pop(context);
                                           statusController.text = activeStatus;
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
                          )
                        ]
                  ),

                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeStatus() async {
   var status = "";
   if(widget.users.status == '0' )
   {
     status = "active";
   }
   else if(widget.users.status == '1' )
   {
     status = "inactive";
   }

    onLoading(context);
    var url = '$CHANGESTATUS_URL?email=${widget.users.email}&status=$status';
    var response = await http.get(url);
    print('Response body: ${response.body}');
    if (response.body.contains("user status changed")) {
      print("done");
      Navigator.pop(context);
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
