import 'package:flutter/material.dart';
import '../Screens/Account_Screen.dart';

class AccountScreenProvider extends StatefulWidget {
  @override
  _AccountScreenProviderState createState() => _AccountScreenProviderState();
}
class _AccountScreenProviderState extends State<AccountScreenProvider>with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive =>true;
  Widget build(BuildContext context) {
      return AccountScreen();
    }
  }

