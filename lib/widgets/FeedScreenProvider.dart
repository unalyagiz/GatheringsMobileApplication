import 'package:flutter/material.dart';
import 'package:flutter_termproject/Models/users.dart';
import 'package:flutter_termproject/services/database.dart';
import 'package:provider/provider.dart';

import '../Screens/Feed_Screen.dart';

class FeedScreenProvider extends StatefulWidget {
  @override
  _HomeScreenProvideState createState() => _HomeScreenProvideState();
}

class _HomeScreenProvideState extends State<FeedScreenProvider>  with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive =>true;
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
      initialData: List(),
      value: DatabaseService().users,
      child: FeedScreen(),
    );
  }
}
