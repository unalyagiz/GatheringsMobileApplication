import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_termproject/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  String email = '';
  String password = '';
  String error = '';

  Widget Loading(){
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitWanderingCubes(
          color: Colors.blue[200],
          size: 60.0,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign in to Gatherings'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register')),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                      errorStyle: TextStyle(color:Colors.teal,fontSize: 14.0,fontWeight: FontWeight.w500),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal, width: 1.8),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                    border:  new OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                    ),
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent,width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      )
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val.trim());
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color:Colors.teal,fontSize: 14.0,fontWeight: FontWeight.w500),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),border:  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent,width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                      )
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 6
                      ? 'Password should be more than 6 characters..'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val.trim());
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.pink[500],
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signIn(email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Invalid email or password.. ';
                          loading = false;
                        });
                      }
                    }
                  }
                ),
                SizedBox(height: 20.0),
                Text(
                  error,style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
