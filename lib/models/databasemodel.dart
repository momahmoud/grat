import 'dart:io';

import 'package:firebase_database/firebase_database.dart';


class User{
  String _name;
  String _location;
  String _phone;
  String _description;
  // File _img;


  User(
    this._name,
    this._location,
    this._phone,
    this._description,
    // this._img
  );


  User.map(dynamic object){
    this._name = object['name'];
    this._location = object['location'];
    this._phone = object['phone'];
    this._description = object['description'];
    // this._img = object['img'];
  }


  String get userName => _name;
  String get userLocation => _location;
  String get userPhone => _phone;
  String get userDescription => _description;
  // File get userImg => _img;



  User.fromSnapShot(DataSnapshot snapshot){
    _name = snapshot.value['name'];
    _location = snapshot.value['location'];
    _phone = snapshot.value['phone'];
    _description = snapshot.value['description'];
    // _img = snapshot.value['img'];
  }


  toSnapShot(){
    var value = {
      "name":_name,
      "location":_location,
      "phone":_phone,
      "description":_description,
      // "img":_img
    };
    return value;
  }

  void selectImage(Future<File> pickImage) async{
    // _img = await pickImage;
  }

}