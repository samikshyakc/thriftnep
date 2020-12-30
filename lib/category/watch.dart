import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/screens/homepage.dart';

class Watch extends StatefulWidget {
  @override
  _WatchState createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  var _pricenegotiable = ["YES", "NO"];
  String _negotiable = "YES";
  var _conditions = ["Used", "Brand New"];
  String _condition = "Used";

  final product_nameController = TextEditingController();
  final product_priceController = TextEditingController();
  final product_usedFor = TextEditingController();
  final product_details = TextEditingController();

  final _globalKeyScaffold = GlobalKey<ScaffoldState>();

  var productName = "";
  var usedfor = "";
  var productPrice = "";
  var productdetails = "";

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String error = 'Error';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1, //automaticallyImplyLeading: false,
        title: Text(
          'Sell Products',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kAppbar,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Form(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    'Fill Details of your product',
                    style: TextStyle(
                        color: kAppbar, fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: product_nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Product Name',
                    ),
                    autofocus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: product_priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Product Price',
                      hintText: 'Enter Product Price',
                    ),
                    autofocus: false,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    items: _pricenegotiable.map((String priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Price Negotiable',
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _negotiable = value;
                      });
                    },
                    value: _negotiable,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    items: _conditions.map((String priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(
                          priority,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Condition',
                      labelStyle: TextStyle(fontSize: 20.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _condition = value;
                      });
                    },
                    value: _condition,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: product_usedFor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Used For',
                    ),
                    autofocus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: product_details,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 8,
                    // maxLength: 512,
                    //  maxLengthEnforced: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      // hintText: 'Enter Product Details',
                      alignLabelWithHint: true,
                    ),
                    autofocus: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FutureBuilder<File>(
                          future: file,
                          builder:
                              (BuildContext context, AsyncSnapshot<File> snapshot) {
                            if (snapshot.connectionState == ConnectionState.done &&
                                null != snapshot.data) {
                              tmpFile = snapshot.data;
                              base64Image =
                                  base64Encode(snapshot.data.readAsBytesSync());
                              return Container(
                                margin: EdgeInsets.all(15),
                                child: Material(
                                  elevation: 3.0,
                                  child: Image.file(
                                    snapshot.data,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            } else if (null != snapshot.error) {
                              return const Text(
                                'Error!',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.all(15),
                                child: Material(
                                  elevation: 3.0,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            'assets/placeholder-image.png'),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          chooseImage();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, right: 10.0),
                                          child: Icon(
                                            Icons.edit,
                                            size: 30.0,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        // Container(
                        //   height: 50.0,
                        //   width: 360.0,
                        //   child: RaisedButton(
                        //     child: Text(
                        //       'Sell Product',
                        //       style: TextStyle(color: Colors.white, fontSize: 18.0),
                        //     ),
                        //     color: kAppbar,
                        //     onPressed: () {
                        //       uploadImg();
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60.0, 8.0, 60.0, 8.0),
                  child: RaisedButton(
                      color: kAppbar,
                      onPressed: () {
                        if (product_nameController != "" &&
                            product_usedFor != "" &&
                            product_priceController != "" &&
                            product_details != "") {
                          productName = product_nameController.text;
                          usedfor = product_usedFor.text;
                          productPrice = product_priceController.text;
                          productdetails = product_details.text;
                          _condition = _condition;
                          _negotiable = _negotiable;
                          uploadImg();
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => HomePage()));
                        } else {
                          _showSnackBar("Fill all fields!!");
                        }
                      },
                      child: Text("SELL", style: TextStyle(color: Colors.white),)),
                ),
              ],
            )),
      ),
    );
  }

  chooseImage() {
    setState(() {
      file =
          ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  uploadImg() {
    if (null == tmpFile) {
      setStatus(error);
      return;
    }

    String fileName = tmpFile.path.split('/').last;

    upload(fileName);
  }

  upload(String fileName) async {
    usedfor = product_usedFor.text;
    productPrice = product_priceController.text;
    productdetails = product_details.text;
    _condition = _condition;
    _negotiable = _negotiable;
    String seller = Provider.of<EmailProvider>(context, listen: false).email();
    var category = "Watch";

    print('$usedfor' + '$productdetails' + '$_condition' + '$fileName');

    // var jsonData = json.encode(map);
    // print(jsonData);

    var map = {
      'image': base64Image,
      'imageName': fileName,
      'name': productName,
      'for' : usedfor,
      'price' : productPrice,
      'condition' : _condition,
      'negotiable' : _negotiable,
      'description' : productdetails,
      'category': category,
      'seller': seller,
    };

    // Response response;
    // var dio = Dio();
    // response = await dio.post(UPLOAD_URL,data:map);
    // options: Options(contentType: ContentType.parse("application/x-www-form-urlencoded")))

    var response = await http.post('$UPLOAD_URL', body: map);
    print(response.body.toString());
    if (response.body.toString().contains('added')) {
      print('Success');
    } else {
      print('Failed');
    }
  }

  void _showSnackBar(String message) {
    final _snackBar = SnackBar(content: Text(message));
    _globalKeyScaffold.currentState.showSnackBar(_snackBar);
  }
}
