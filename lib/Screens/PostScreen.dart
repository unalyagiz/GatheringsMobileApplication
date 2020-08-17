import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_termproject/Models/Posts.dart';
import 'package:flutter_termproject/Models/users.dart';

import 'Chat.dart';

class PostScreen extends StatefulWidget {
  final Post post;
  final User usr;

  PostScreen({this.post, this.usr});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 80,
                color: Colors.blueAccent,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 25.0,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.usr.name + ' ' + widget.usr.surname + "'s Post",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 120.0, 15.0, 0.0),
                child: Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: _color(widget.post)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 15.0),
                      child: Text(
                        widget.post.text,
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(17.0, 10.0, 0.0, 0.0),
                child: Column(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.chat,
                          color: Colors.lightBlueAccent,
                        ),autofocus: true,
                        tooltip: 'Start Chatting!',
                        iconSize: 35.0,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    Chat(postOwner: widget.usr)))),
                    Text(
                      'Start Chatting!',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

_color(Post post) {
  if (post.category == 'Sport') {
    return Colors.amber[400];
  } else if (post.category == 'Education') {
    return Colors.lightBlue[100];
  } else {
    return Colors.redAccent;
  }
}
