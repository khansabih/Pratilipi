import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pratilipi/FullViewStories/fullViewStory.dart';
import 'package:pratilipi/StartingPoint/LogIn.dart';
import 'package:pratilipi/Widgets/StoryFetchingSection/storyFetch.dart';

class showStories extends StatefulWidget{

  final UserCredential userDocs;

  const showStories({Key key, this.userDocs}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new showStoriesState();
  }

}

class showStoriesState extends State<showStories>{

  // void updateCurrentViewing(DocumentSnapshot story) async{
  //   FirebaseFirestore.instance.collection('Stories')
  //       .doc(story.data()['id']).update({
  //     'current_viewer':story.data()['current_viewer']+1
  //   }).catchError((error){
  //
  //   });
  // }

  // Widget getStories(){
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection('Stories').snapshots(),
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
  //       if (snapshot.hasError)
  //         return new Text('Error: ${snapshot.error}');
  //       switch (snapshot.connectionState) {
  //       case ConnectionState.waiting: return Center(
  //         child: Image.asset('assets/screenLoader.gif'));
  //         default:
  //           return Container(
  //             alignment: Alignment.centerRight,
  //             child: new ListView(
  //               shrinkWrap: true,
  //               reverse: true,
  //               children: snapshot.data.docs.map((DocumentSnapshot document) {
  //                 print('${document.data()['title']}');
  //                 return GestureDetector(
  //                   child: Container(
  //                     alignment: Alignment.centerLeft,
  //                     margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 10.0,top: 10.0),
  //                     child: Text('${document.data()['title']}',
  //                       style: TextStyle(
  //                           // fontSize: double.parse('${document.data()['fontSize']}'),
  //                           color: Colors.black
  //                       ),),
  //                   ),
  //                   onTap: () async{
  //                     await updateCurrentViewing(document);
  //                     Navigator.of(context).push(
  //                       new MaterialPageRoute(
  //                           builder: (BuildContext context)=>new fullViewStory(
  //                             story: document,
  //                           )
  //                       )
  //                     );
  //                   },
  //                 );
  //
  //               }).toList(),
  //             ),
  //           );
  //
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Text("Explore stories",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Playfair',
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  fontSize: 35.0
              ),),
          ),
          centerTitle: false,
          actions: <Widget>[
            IconButton(
             icon: Icon(Icons.close,color: Colors.black,),
             onPressed: (){
               FirebaseAuth.instance.signOut().then((value){
                 Navigator.of(context).pushReplacement(
                     new MaterialPageRoute(builder: (BuildContext context)=> new Login()
                     )
                 );
               });
             },
            )
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 10.0,right: 10.0),
          child: storyFetch()
      )
    );
  }
}

/*
RaisedButton(
              child: Center(
                child: Text("Log out"),
              ),
              onPressed: (){
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (BuildContext context)=> new Login()
                    )
                  );
                });
              },
            )
* */