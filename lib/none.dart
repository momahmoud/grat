// Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(begin: Alignment.topCenter, colors: [
//         Colors.orange[900],
//         Colors.orange[800],
//         Colors.orange[400]
//       ])),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(
//             height: 30,
//           ),
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Login",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 40,
//                   ),
//                 ),
//                 Text(
//                   "Welcome back",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(60),
//                       topRight: Radius.circular(60))),
//               child: Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color.fromRGBO(225, 95, 27, .3),
//                               blurRadius: 20,
//                               offset: Offset(0, 10),
//                             )
//                           ]),
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                                 border: Border(
//                                     bottom: BorderSide(
//                               color: Colors.grey[200],
//                             ))),
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: " Email",
//                                 hintStyle: TextStyle(
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                                 border: Border(
//                                     bottom: BorderSide(
//                               color: Colors.grey[200],
//                             ))),
//                             child: TextFormField(
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: " Password",
//                                 hintStyle: TextStyle(
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Forget Password",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       height: 40,
//                       margin: EdgeInsets.symmetric(horizontal: 30),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(40),
//                         color: Colors.orange[900],
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20,),
//                     Text("or", style: TextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold
//                     )),
                   
//                     SizedBox(height: 20,),
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: Container(
//                             height: 45,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40),
//                               color: Colors.blue,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Sign Up", 
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 20,),
//                         Expanded(
//                           child: Container(
//                             height: 45,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40),
//                               color: Colors.blue,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Google",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     )