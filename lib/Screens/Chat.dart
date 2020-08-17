import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_termproject/Models/users.dart';
import 'package:flutter_termproject/widgets/Messages.dart';

class Chat extends StatefulWidget {
  final User postOwner;

  Chat({this.postOwner});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String id;
  String name;
  String surname;

  Future<void> messageShow() async {
    if (messageController.text.length > 0) {
      await _firestore
          .collection('messages')
          .document(widget.postOwner.uid)
          .collection(widget.postOwner.uid)
          .add({
        'text': messageController.text,
        'from': '$name $surname',
        'date': DateTime.now().toIso8601String().toString(),
        'uid': id,
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: Duration(microseconds: 300),
      );
    }
  }
  void getUID() async {
    final FirebaseUser user = await _auth.currentUser();
    setState(() {
      id = user.uid;
    });
    var d = await _firestore.collection('account').document(id).get();
    name = d.data['name'];
    surname = d.data['surname'];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Meet Up!"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .document(widget.postOwner.uid)
                    .collection(widget.postOwner.uid)
                    .orderBy('date')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  List<DocumentSnapshot> docs = snapshot.data.documents;
                  List<Widget> messages = docs
                      .map((doc) => Message(
                            from: doc.data['from'],
                            text: doc.data['text'],
                            me: doc.data['uid'] == id,
                          ))
                      .toList();
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView(
                      controller: scrollController,
                      children: <Widget>[...messages],
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Send message..',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        controller: messageController,
                      ),
                    ),
                    Container(
                      width: 45.0,
                      child: FlatButton(
                        child: Icon(
                          Icons.send,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: messageShow,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
