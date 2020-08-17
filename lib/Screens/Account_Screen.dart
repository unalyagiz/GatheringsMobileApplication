import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_termproject/Models/Posts.dart';
import 'package:flutter_termproject/Models/users.dart';
import 'package:flutter_termproject/services/database.dart';
import 'package:flutter_termproject/widgets/Add_Post.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _surname;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    void _showSettingsPanel() {
      showModalBottomSheet( context: context, builder: (context) {
        return Container(
          color: Colors.brown[100],
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: AddPost(),
        );
      });
    }
    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            User usr = snapshot.data;
            return Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update your Profile',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: usr.name,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 2.0),
                        ),
                      ),
                      validator: (val) =>
                      val.isEmpty ? 'This field should not be empty' : null,
                      onChanged: (val) => setState(() => _name = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: usr.surname,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 2.0),
                        ),
                      ),
                      validator: (val) =>
                      val.isEmpty ? 'This field should not be empty' : null,
                      onChanged: (val) => setState(() => _surname = val),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'MY POSTS',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(width: 30.0),
                    Padding(
                      padding:  EdgeInsets.only(right: 15.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child:  Icon(
                              Icons.add_circle,size: 40.0,
                              color: Colors.lightBlueAccent,
                            ),
                            onPressed: _showSettingsPanel,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            itemCount: usr.posts.length,
                            itemBuilder: (BuildContext c, int i) {
                              Post pst = usr.posts[i];
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 25.0,
                                    child: _icon(pst),
                                  ),
                                  trailing: FlatButton(
                                    child: Icon(Icons.delete_forever,
                                        color: Colors.red),
                                    onPressed: () async {
                                      DocumentReference docRef = Firestore
                                          .instance
                                          .collection('account')
                                          .document(usr.uid);
                                      DocumentSnapshot doc = await docRef.get();
                                      List post = doc.data['post'];
                                      docRef.updateData({
                                        'post': FieldValue.arrayRemove([
                                          {
                                            'category': pst.category,
                                            'text': pst.text
                                          }
                                        ])
                                      });
                                    },
                                  ),
                                  title: Text(pst.category),
                                  subtitle: Text(pst.text),
                                ),
                              );
                            }),
                      ),
                    ),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            DocumentReference docRef = Firestore.instance
                                .collection('account')
                                .document(usr.uid);
                            DocumentSnapshot doc = await docRef.get();
                            docRef.updateData({
                              'name': _name ?? usr.name,
                              'surname': _surname ?? usr.surname
                            });
                          }
                        }),
                  ],
                ),
              ),
            );
          }
          else{
            return CircularProgressIndicator();
          }
        });
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

void _showToast(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Updating..'),
    ),
  );
}

