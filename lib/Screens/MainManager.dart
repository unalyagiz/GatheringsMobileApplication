import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/YGU/IdeaProjects/flutter_termproject/lib/widgets/Account_Screen_Provider.dart';
import 'file:///C:/Users/YGU/IdeaProjects/flutter_termproject/lib/widgets/FeedScreenProvider.dart';
import 'package:flutter_termproject/services/auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _auth = AuthService();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  GlobalKey<ScaffoldState> key= new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    FeedScreenProvider(),
    AccountScreenProvider()
  ];
  PageController pageController = PageController();

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        key.currentState.showSnackBar(new SnackBar(elevation: 6.0,backgroundColor:Colors.blue,duration: Duration(seconds: 3),
          content: Text(message['notification']['body'],style: TextStyle(fontSize: 18.0),),
          action: SnackBarAction(textColor: Colors.black87,
            label: 'See',
            onPressed: ()=>{},//to navigate to another screen
          ),
        ));
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        key.currentState.showSnackBar(new SnackBar(elevation: 6.0,backgroundColor:Colors.blue,duration: Duration(seconds: 3),
          content: Text(message['notification']['body'],style: TextStyle(fontSize: 18.0),),
          action: SnackBarAction(textColor: Colors.black87,
            label: 'See',
            onPressed: ()=>{},//to navigate to another screen
          ),
        ));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        key.currentState.showSnackBar(new SnackBar(duration: Duration(seconds: 3 ),
          content: Text(message['notification']['title']),
          action: SnackBarAction(
            label: 'See',
            onPressed: ()=>{},//to navigate to another screen
          ),
        ));
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gatherings'),
        backgroundColor: Colors.lightBlue,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text('logout'),
            icon: Icon(Icons.power_settings_new),
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: _onItemTapped,
        children: _widgetOptions,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlueAccent,
        onTap: _onItemTapped,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
