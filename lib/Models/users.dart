import 'package:flutter_termproject/Models/Posts.dart';

class User {
  String uid;
  String name;
  String surname;
  List<Post> posts;

  User({this.uid, this.name, this.posts, this.surname});
}
