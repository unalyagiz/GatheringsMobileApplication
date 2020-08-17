import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_termproject/Models/Posts.dart';
import 'package:flutter_termproject/Models/users.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference accountCollection = Firestore.instance.collection('account');
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  Future updateUserData(
      String name, String surname, String ca, String te) async {
    return await accountCollection.document(uid).setData({
      'uid':uid,
      'name': name,
      'surname': surname,
      'token':  await _firebaseMessaging.getToken(),
      'post': [
        {'category': 'Sport', 'text': 'I like sport'},
        {'category': 'Education', 'text': 'I like education'},
        {'category': ca, 'text': te}
      ],
    });
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: uid,
      name: snapshot.data['name'],
      surname: snapshot.data['surname'],
      posts: List<Post>.from(snapshot.data["post"].map((item) {
        return new Post(category: item["category"], text: item["text"]);
      })),
    );
  }

  Stream<User> get userData {
    return accountCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  List<User> _userfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
          uid: doc.data['uid'] ,
          name: doc.data['name'] ?? '',
          surname: doc.data['surname'] ?? '',
          posts: List<Post>.from(doc.data["post"].map((item) {
            return new Post(category: item["category"], text: item["text"]);
          })));
    }).toList();
  }

  Stream<List<User>> get users {
    return accountCollection.snapshots().map(_userfromsnapshot);
  }
}
