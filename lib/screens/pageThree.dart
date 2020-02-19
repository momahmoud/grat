import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class PageThree extends StatefulWidget {
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  // static const platform = const MethodChannel('samples.flutter.dev/battery');
  File _image;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("image upload");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("image is uploaded")));
    });
  }

  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  // Future<void> _getBatteryLevel() async {
  //   String batteryLevel;
  //   try {
  //     final int result = await platform.invokeMethod('getBatteryLevel');
  //     batteryLevel = 'Battery level at $result % .';
  //   } on PlatformException catch (e) {
  //     batteryLevel = "Failed to get battery level: '${e.message}'.";
  //   }

  //   setState(() {
  //     _batteryLevel = batteryLevel;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
             child: Column(
               children: <Widget>[
                 Card(
            elevation: 15,
            child: MaterialButton(
              elevation: 20,
              onPressed: () {
                getImage();             
                uploadPic(context);
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add_photo_alternate,
                    color: Colors.pink[700],
                    size: 32,
                  ),
                  Text(
                    "Gallery",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "ubuntu-Bold"),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
                        elevation: 15,
                        color: Colors.pink[700],
                        onPressed: () {
                         
                              uploadPic(context);
                        },
                        child: Text(
                          "Post",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "ubuntu-Bold",
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                //  RaisedButton(
                //    child: Text('Get Battery Level'),
                //    onPressed: _getBatteryLevel,
                //  ),
                //  Text(_batteryLevel),
               ],
             )
          
        
      ),
    );
  }
}
