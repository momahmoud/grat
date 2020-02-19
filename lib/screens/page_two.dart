import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


const textStyle1 = TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        );
const textStyle2 = TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        );

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  void getPersonData() async{
     await for(var snapshot in _firestore.collection("Posts").snapshots()){
       for(var post in snapshot.documents){
      print(post.data);
    }
     }
    
  }
  
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
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection("Posts").snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }
                final posts = snapshot.data.documents;
                List<Widget> postWidgets = [];
                for(var post in posts){

                  final nameText = post.data["name"];
                  final locationText = post.data["location"];
                  final phoneText = post.data["phone"];
                  final desciptionText = post.data["description"];
                  final img = post.data["imageGallery"];


                  final Widget postWidget = Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Name:", style: textStyle1 ),
                      SizedBox(width: 5,),
                      Text(nameText,style: textStyle2 )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Location:", style: textStyle1,),
                      SizedBox(width: 5,),
                      Text(locationText, style: textStyle2,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Phone:", style: textStyle1,),
                      SizedBox(width: 5,),
                      Text(phoneText, style: textStyle2,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Description:", style: textStyle1),
                      SizedBox(width: 5,),
                      Text(desciptionText, style: textStyle2,)
                    ],
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     height: 170,
                     width: MediaQuery.of(context).size.width,
                     child: Image(image: AssetImage(img), fit: BoxFit.contain,)),
                 ),         
              ],
            ),
          );
          postWidgets.add(postWidget);
                }
                return Container(
                  child: Column(
                    children: postWidgets,
                  ),
                );    
            },
          ),         
        ],
      ),
    );
  }
}