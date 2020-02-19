import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name, location, phone, description;
  Firestore _firestore = Firestore.instance;
  File _imageCamera;
  File _imageGallery;

  void addPost() {
    _firestore.collection("Posts").add({
      'name': name,
      'location': location,
      'phone': phone,
      'description': description,
      'imageGallery': _imageGallery,
      
    });
  }

  void selectImage(Future<File> pickImage, int imageType) async {
    File _imgTemp = await pickImage;
    switch(imageType){
      case 1: setState(()=> _imageCamera = _imgTemp);
      break;
      case 2: setState(()=> _imageGallery = _imgTemp);
      break;
    }
   
  } 

  // File _image;
  // Future getImage() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _image = image;
  //   });
  // }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffc7006e),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
        title: Text(
          "Lost People",
          style: TextStyle(
            fontFamily: "ubuntu-Bold",
          ),
        ),
      ),
      drawer: Drawer(),
      body: ListView(
        children: <Widget>[
          Form(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Add Post",
                        style: TextStyle(
                          color: Color(0xffef0078),
                          fontFamily: "ubuntu-Bold",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Name:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "ubuntu-Bold"),
                  ),
                  Card(
                    elevation: 5,
                    child: TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Enter a name",
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "location:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "ubuntu-Bold"),
                  ),
                  Card(
                    elevation: 5,
                    child: TextField(
                      onChanged: (value) {
                        location = value;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Enter your Location",
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Phone:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "ubuntu-Bold"),
                  ),
                  Card(
                    elevation: 5,
                    child: TextField(
                      onChanged: (value) {
                        phone = value;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Enter your Phone",
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Description:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "ubuntu-Bold"),
                  ),
                  Card(
                    elevation: 5,
                    child: TextField(
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Enter a description of person",
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Add photo:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "ubuntu-Bold"),
                  ),
                  Card(
                    elevation: 0,
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              elevation: 15,
                              child: Column(
                                children: <Widget>[
                                  MaterialButton(
                                elevation: 20,
                                onPressed: () {
                                  // getImage();
                                   selectImage(ImagePicker.pickImage(
                                       source: ImageSource.gallery),2);
                                },
                                child: _displayImageGallery()
                              ),
                               FlatButton(
                                 onPressed: (){
                                   uploadPic(context, _imageGallery);
                                 },
                                
                                 child: Text("save"),
                               )
                                ],
                              )
                            ),
                          ),
                          Expanded(
                            child: Card(
                              elevation: 15,
                              child: Column(
                                children: <Widget>[
                                  OutlineButton(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(.5),
                                    width: 2),
                                onPressed: () {
                                  selectImage(ImagePicker.pickImage(
                                      source: ImageSource.camera),1);
                                },
                                child: _displayImageCamera()
                              ),
                              FlatButton(
                                onPressed: (){
                                  uploadPic(context, _imageCamera);
                                },
                                child: Text("save"),
                              )
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      width: 200,
                      child: MaterialButton(
                        elevation: 15,
                        color: Colors.pink[700],
                        onPressed: () {
                          // addUser(User(txtName.text, txtLocation.text,
                          //     txtPhone.text, txtDescription.text));
                          //     uploadPic(context);
                          addPost();
                          
                          uploadPic(context,_imageGallery);
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
                    ),
                  )
                ],
              ),
              elevation: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget _displayImageCamera() {
    if (_imageCamera == null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 60, 10, 60),
        child: Icon(
          Icons.add_a_photo,
          color: Colors.pink[700],
          size: 32,
        ),
      );
    }
    else{
      return  Image.file(_imageCamera,fit: BoxFit.cover);
      
    }
  }
    Widget _displayImageGallery() {
    if (_imageGallery == null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 60, 10, 60),
        child: Icon(
          Icons.add_photo_alternate,
          color: Colors.pink[700],
          size: 32,
        ),
      );
    }
    else{
      return  Image.file(_imageGallery,fit: BoxFit.cover);
      
    }
  }
  Future uploadPic(BuildContext context, var _imageSource) async {
    String fileName = basename(_imageSource.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageSource);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      print("image upload");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("image is uploaded")));
    });
  }
}
