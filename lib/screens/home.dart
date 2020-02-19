import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lostpeople/screens/homePage.dart';
import 'package:lostpeople/screens/pageThree.dart';
import 'package:lostpeople/screens/page_two.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int pageIndex = 0;
  final HomePage pageOne = HomePage();
  final PageTwo  pageTwo = PageTwo();
  final PageThree pageThree =PageThree();

  Widget showPage = new PageTwo();

  Widget pageChooser(int page){
    switch(page){
      case 0:
      return pageTwo;
      break;
      case 1:
      return pageOne;
      break;
      case 2:
      return pageThree;
      break;
      default:
      return new Container(
        child: Center(
          child: Text(
            "No page founded",
            style: TextStyle(
              fontSize: 22
            ),
          ),
        ),
      );
    }
  }

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: pageIndex,
          key: _bottomNavigationKey,
          items: <Widget>[
            Icon(Icons.home, size: 30,color: Colors.white,),
            Icon(Icons.list, size: 30, color: Colors.white,),
            Icon(Icons.person, size: 30, color: Colors.white,),
          ],
          color: Color(0xffc7006e),
          animationCurve: Curves.easeInOut,
          backgroundColor: Colors.white,
          // buttonBackgroundColor: Colors.white,
          height: 55,
          animationDuration: Duration(
            milliseconds: 500
          ),
          onTap: (int tapPage) {
            setState(() {
              showPage = pageChooser(tapPage);
            });
          },
        ),
        body: Container(
          // color: Color(0Xffee0290),
          child: Center(
            child: showPage,
            // child: Column(
            //   children: <Widget>[
            //     Text(_page.toString(), textScaleFactor: 10.0),
            //     RaisedButton(
            //       child: Text('Go To Page of index 1'),
            //       onPressed: () {
            //         //Page change using state does the same as clicking index 1 navigation button
            //         final CurvedNavigationBarState navBarState =
            //             _bottomNavigationKey.currentState;
            //         navBarState.setPage(1);
            //       },
            //     )
            //   ],
            // ),
          ),
        )
      
    );
  }
}