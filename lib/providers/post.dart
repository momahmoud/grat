
import 'package:flutter/foundation.dart';

class Post with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String phone;
  final String imageUrl;
  final String location;

  Post({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.phone,
    @required this.imageUrl,
    @required this.location,
  });

  

  
}
