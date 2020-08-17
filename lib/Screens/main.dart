import 'package:flutter/material.dart';
import 'package:flutter_termproject/Models/users.dart';
import 'package:flutter_termproject/Screens/Feed_Screen.dart';
import 'package:english_words/english_words.dart';
import 'file:///C:/Users/YGU/IdeaProjects/flutter_termproject/lib/widgets/wrapper.dart';
import 'package:flutter_termproject/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),

    );
  }
}

