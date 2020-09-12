import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class storyTileUtility extends StatefulWidget{

  final String bookName, bookAuthor;

  const storyTileUtility({Key key, this.bookName, this.bookAuthor}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new storyTileUtilityState();
  }

}

class storyTileUtilityState extends State<storyTileUtility>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black,Color(0xff272727)],
        // )],
          tileMode: TileMode.clamp,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight
        ),
        // color: Colors.white,
        border: Border.all(color: Colors.white,width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 3,
            offset: Offset(0,3)
          )
        ]
      ),
      child: Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("${widget.bookName}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontFamily: 'Playfair',
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold
              ),),

              SizedBox(height: 5.0,),

              Text("${widget.bookAuthor}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'Playfair',
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold
                ),),
            ],
          ),
        ),
      ),
    );
  }
}