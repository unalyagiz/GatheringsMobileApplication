import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_termproject/Models/users.dart';
import 'package:flutter_termproject/services/database.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();
  List<String> postcategory = ['Sport', 'Social', 'Education'];
  String _postCategory;
  String _postText;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          User usr = snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Add post',
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField(
                value: _postCategory ?? postcategory[0],
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
                items: postcategory.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _postCategory = val),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: 'Post text',
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
                validator: (val) => val.isEmpty ? 'Please enter a text' : null,
                onChanged: (val) => setState(() => _postText = val),
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                color: Colors.pink[400],
                onPressed: ()async{
                  if (_formKey.currentState.validate()) {
                    DocumentReference docRef = Firestore.instance
                        .collection('account')
                        .document(usr.uid);
                    DocumentSnapshot doc = await docRef.get();
                    List post = doc.data['post'];
                    docRef.updateData({
                      'post': FieldValue.arrayUnion([
                        {
                          'category': _postCategory,
                          'text': _postText
                        }
                      ])
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
