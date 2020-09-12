import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pratilipi/HomePage/showStories.dart';

class fullViewStory extends StatefulWidget{

  final DocumentSnapshot story;

  const fullViewStory({Key key, this.story}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new fullViewStoryState();
  }

}

class fullViewStoryState extends State<fullViewStory>{

  void checkIfAlreadyRead(){
    String userId = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('Stories')
    .doc(widget.story.data()['id']).collection('ReadBy')
    .doc(userId).get().then((value){
      if(value==null || !value.exists){
        updateReadCounts(userId);
      }
    });
  }

  void updateReadCounts(String userId){
      FirebaseFirestore.instance.collection('Stories')
          .doc('${widget.story.data()['id']}').collection('ReadBy')
          .doc(userId).set({
            'id':userId,
            'read':true
      }).then((value){
        // setState(() {
        //   widget.story.data()['read_counts'] = widget.story.data()['read_counts']+1;
        // });
        FirebaseFirestore.instance.collection('Stories')
            .doc('${widget.story.data()['id']}').get().then((value){
          FirebaseFirestore.instance.collection('Stories')
              .doc('${widget.story.data()['id']}').update({
              'read_counts': value.data()['read_counts']+1
          });
        });
      });
    }

  Widget showCurrentViewing(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Stories').where('id',isEqualTo: widget.story.data()['id']).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError)
          return new Text('Current Viewers - 0');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return Center(
          child: new Text('Current Viewers - 0'));
          default:
            return Container(
              alignment: Alignment.center,
              child: new ListView(
                shrinkWrap: true,
                reverse: true,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  print('${document.data()['title']}');
                  return Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          Icon(Icons.visibility,color: Colors.green,),

                          SizedBox(width: 10.0,),

                          Text('Current viewers : ${document.data()['current_viewer']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Playfair',
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0
                            ),
                          ),
                        ],
                      ),
                  );
                }).toList(),
              ),

            );
        }
      },
    );
  }


  @override
  void initState() {
    super.initState();
    checkIfAlreadyRead();
    // updateCurrentViewing();
  }


  @override
  void dispose() {
    super.dispose();
    FirebaseFirestore.instance.collection('Stories')
        .doc('${widget.story.data()['id']}').get().then((value){
      FirebaseFirestore.instance.collection('Stories')
          .doc('${widget.story.data()['id']}').update({
        'current_viewer': (value.data()['current_viewer']>0)?value.data()['current_viewer']-1:0
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Container(
              child: Center(
                child: Text('${widget.story.data()['title']}',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Playfair',
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                  fontSize: 30.0,
                ),),
              ),
            ),

            SizedBox(height: 5.0,),

            Container(
              child: Center(
                child: Text('${widget.story.data()['author']}',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Playfair',
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0
                  ),),
              ),
            ),

            SizedBox(height: 5.0,),

            Container(
              child: Center(
                child: showCurrentViewing(),
              ),
            ),

            SizedBox(height: 5.0,),

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.group,color: Colors.yellow,),
                  SizedBox(width: 10.0,),
                  Container(
                    child: Center(
                      child: Text('Total Read count : ${widget.story.data()['read_counts']}',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Playfair',
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0
                      ),),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.0,),

            Container(
              child: Center(
                child: Text('${widget.story.data()['description']}',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Playfair',
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    wordSpacing: 1.5
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}