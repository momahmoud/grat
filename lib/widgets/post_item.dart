import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../screens/product_detail_screen.dart';
import '../providers/post.dart';


class PostItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Post>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   ProductDetailScreen.routeName,
            //   arguments: product.id,
            // );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Post>(
            builder: (ctx, product, _) => IconButton(
                  icon: Icon(
                     Icons.share,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    
                  },
                ),
          ),
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.comment,
            ),
            onPressed: () {
              // cart.addItem(product.id, product.price, product.title);
              // Scaffold.of(context).hideCurrentSnackBar();
              // Scaffold.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //       'Added item to cart!',
              //     ),
              //     duration: Duration(seconds: 2),
              //     action: SnackBarAction(
              //       label: 'UNDO',
              //       onPressed: () {
              //         cart.removeSingleItem(product.id);
              //       },
              //     ),
              //   ),
              // );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
