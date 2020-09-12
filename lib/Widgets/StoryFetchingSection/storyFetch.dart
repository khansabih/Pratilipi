import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pratilipi/FullViewStories/fullViewStory.dart';
import 'package:pratilipi/Widgets/StoryFetchingSection/storyTileUtility.dart';

class storyFetch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new storyFetchState();
  }

}

class storyFetchState extends State<storyFetch>{

  void updateCurrentViewing(DocumentSnapshot story) async{
    FirebaseFirestore.instance.collection('Stories')
        .doc(story.data()['id']).update({
      'current_viewer':story.data()['current_viewer']+1
    }).catchError((error){

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Stories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return Center(
              child: Image.asset('assets/screenLoader.gif'));
          default:
            return Container(
              alignment: Alignment.centerRight,
              child: new ListView(
                shrinkWrap: true,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  print('${document.data()['title']}');
                  return GestureDetector(
                    child: storyTileUtility(
                      bookName: '${document.data()['title']}',
                      bookAuthor: '${document.data()['author']}',
                    ),
                    onTap: () async{
                      await updateCurrentViewing(document);
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context)=>new fullViewStory(
                                story: document,
                              )
                          )
                      );
                    },
                  );

                }).toList(),
              ),
            );

        }
      },
    );
  }
}