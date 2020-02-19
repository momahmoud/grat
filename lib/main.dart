import 'package:lostpeople/screens/post_detail_screen.dart';
import 'package:lostpeople/screens/posts_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'providers/posts.dart';
import 'screens/auth_screen.dart';
import 'screens/edit_post_screen.dart';
import 'providers/auth.dart';
import 'screens/user_post_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Posts(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mafkood',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home:  AuthScreen(),
          // : FutureBuilder(
          //     future: auth.tryAutoLogin(),
          //     builder: (ctx, authResultSnapshot) =>
          //         authResultSnapshot.connectionState ==
          //                 ConnectionState.waiting
          //             ? SplashScreen()
          //             : AuthScreen(),
          //   ),
          routes: {
            // PostDetailScreen.routeName: (ctx) => PostDetailScreen(),
            PostsOverviewScreen.routeName: (ctx) => PostsOverviewScreen(),           
            UserPostScreen.routeName: (ctx) => UserPostScreen(),
            EditPostScreen.routeName: (ctx) => EditPostScreen(),
          },
        ),
      ),
    );
  }
}
