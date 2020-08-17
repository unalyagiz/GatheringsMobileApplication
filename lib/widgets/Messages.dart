import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String text;

  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
        child: Column(
          crossAxisAlignment:
          me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              from,
              style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w600,fontSize: 12.5) ,
            ),
            SizedBox(height: 5.0,),
            Material(
              color: me ? Colors.lightBlueAccent : Colors.red,
              borderRadius: BorderRadius.circular(10.0),
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(
                  text,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0) ,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
