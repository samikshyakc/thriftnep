import 'dart:convert';
import 'dart:io';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thrift_nep/widgets/loading_indicator.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String error = 'Error';





  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery,  imageQuality: 50);
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
    onLoading(context);
    var map = new Map<String, dynamic>();
    map['image'] = base64Image.toString();
    map['imageName'] = fileName;
    var response = await http.post('$UPLOAD_URL', body: map);
    print(response);
    Navigator.pop(context);
    if(response.body.toString().contains('image')){
      print('Success');

    }else{
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1, //automaticallyImplyLeading: false,
          title: Text(
            'Sell Products',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<File>(
                future: file,
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      null != snapshot.data) {
                    tmpFile = snapshot.data;
                    base64Image = base64Encode(snapshot.data.readAsBytesSync());
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
                              child: Image.asset('assets/placeholder-image.png'),
                            ),
                            InkWell(
                              onTap: () {
                                chooseImage();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.0, right: 10.0),
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
              Container(
                height: 50.0,
                width: 360.0,
                child: RaisedButton(
                  child: Text(
                    'Sell Product',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  color: kAppbar,
                  onPressed: () {
                    uploadImg();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => HomePage()));



                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
