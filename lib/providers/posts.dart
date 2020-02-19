import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './post.dart';

class Posts with ChangeNotifier {
  List<Post> _items = [
    // Post(
    //   location: "cairo",
    //   id: 'p1',
    //   name: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   phone: "29.99",
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Post(
    //   location: "cairo",
    //   id: 'p2',
    //   name: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   phone: "59.99",
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Post(
    //   location: "cairo",
    //   id: 'p3',
    //   name: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   phone: "19.99",
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Post(
    //   location: "cairo",
    //   id: 'p4',
    //   name: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   phone: "49.99",
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var _showFavoritesOnly = false;

  List<Post> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return _items;
  }

  

  Post findById(String id) {
    return _items.firstWhere((prod) => prod.id == id, );
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetPosts() async {
    const url = 'https://lostpeople-2c7d7.firebaseio.com/Posts.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Post> loadedPosts = [];
      extractedData.forEach((prodId, prodData) {
        loadedPosts.add(Post(
          id: prodId,
          name: prodData['name'],
          description: prodData['description'],
          phone: prodData['phone'],    
          imageUrl: prodData['imageUrl'],
          location: prodData['location'],
        ));
      });
      _items = loadedPosts;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addPost(Post post) async {
    const url = 'https://lostpeople-2c7d7.firebaseio.com/Posts.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': post.name,
          'description': post.description,
          'imageUrl': post.imageUrl,
          'phone': post.phone,
          'location': post.location,
          
        }),
      );
      final newPost = Post(
        name: post.name,
        description: post.description,
        phone: post.phone,
        imageUrl: post.imageUrl,
        location: post.location,
        id: json.decode(response.body)['title'],
      );
      _items.add(newPost);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updatePost(String id, Post newPost) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://lostpeople-2c7d7.firebaseio.com/Posts.json';
      await http.patch(url,
          body: json.encode({
            'name': newPost.name,
            'description': newPost.description,
            'imageUrl': newPost.imageUrl,
            'phone': newPost.phone,
            'location': newPost.location,
          }));
      _items[prodIndex] = newPost;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deletePost(String id) async {
    final url = 'https://lostpeople-2c7d7.firebaseio.com/Posts.json';
    final existingPostIndex = _items.indexWhere((prod) => prod.id == id);
    var existingPost = _items[existingPostIndex];
    _items.removeAt(existingPostIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingPostIndex, existingPost);
      notifyListeners();
      throw HttpException('Could not delete post.');
    }
    existingPost = null;
  }
}
