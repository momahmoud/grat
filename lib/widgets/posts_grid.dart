import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/posts.dart';
import './post_item.dart';

class PostsGrid extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<Posts>(context).items;
    
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: postsData.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            // builder: (c) => products[i],
            value: postsData[i],
            child: PostItem(
                // products[i].id,
                // products[i].title,
                // products[i].imageUrl,
                ),
          ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
