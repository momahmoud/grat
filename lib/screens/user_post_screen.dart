import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/posts.dart';
import '../widgets/user_post_item.dart';
import '../widgets/app_drawer.dart';
import './edit_post_screen.dart';

class UserPostScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Posts>(context).fetchAndSetPosts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Posts>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Post'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditPostScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => Column(
                  children: [
                    UserPostItem(
                      productsData.items[i].id,
                      productsData.items[i].name,
                      productsData.items[i].imageUrl,
                    ),
                    Divider(),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
