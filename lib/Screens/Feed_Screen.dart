import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_termproject/Models/Posts.dart';
import 'package:flutter_termproject/Models/users.dart';
import 'package:flutter_termproject/Screens/PostScreen.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    final user = Provider.of<List<User>>(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            child: Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: user.length,
                  itemBuilder: (BuildContext context, int index) {
                    User usr = user[index];
                    List<Post> psts = usr.posts;
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: psts.length,
                      itemBuilder: (BuildContext ct, int i) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PostScreen(
                                    post: psts[i],
                                usr: usr,
                                  ))),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin:
                                EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                            height: 170,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: _color(psts[i]),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.0, vertical: 0.0),
                                      child: ClipRRect(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                _icon(psts[i]),
                                                Text(psts[i].category)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                Row(
                                    children: <Widget>[
                                  Container(
                                    child: Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          children: <Widget>[
                                            Text(
                                              psts[i].text,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                      FontWeight
                                                          .w500,
                                                  color: Colors
                                                      .black87,
                                                  letterSpacing:
                                                      1.1),
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              maxLines: 2,
                                            ),
                                            SizedBox(height: 40.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .end,
                                              children: <Widget>[
                                                Text(
                                                  user[index].name +
                                                      ' ' +
                                                      user[index]
                                                          .surname,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight
                                                              .w500),
                                                ),
                                              ],
                                            )
                                              ],
                                            ),
                                          ),
                                        ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                        });
                  }),
            ),
          ),
        )
      ],
    );
  }
}


_icon(Post post) {
  if (post.category == 'Sport')
    return Icon(Icons.directions_run);
  else if (post.category == 'Education') {
    return Icon(Icons.school);
  } else {
    return Icon(Icons.people);
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
