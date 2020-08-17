import 'package:flutter/material.dart';
import 'package:flutter_termproject/Screens/MainManager.dart';
import 'package:flutter_termproject/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_termproject/Models/users.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user==null){
      return Authenticate();
    }
    else{
      return MyHomePage();
    }
  }
}

