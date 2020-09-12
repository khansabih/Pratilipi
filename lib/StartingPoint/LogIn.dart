import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pratilipi/Widgets/DisplayPicture/DisplayPic.dart';
import 'package:pratilipi/Widgets/inputFields/inputField.dart';
import 'package:pratilipi/Widgets/inputFields/inputFieldPassword.dart';
import 'package:pratilipi/Widgets/myButtons/customButtons.dart';
import 'SignUp.dart';
import 'package:pratilipi/HomePage/showStories.dart';
import 'package:crypto/crypto.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginState();
  }

}

class LoginState extends State<Login>{

  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  String _error = "";

  int isLoading = 0;
  String decryptPassword(String pw){
    var bytes = utf8.encode(pw);
    var decPass = sha256.convert(bytes);
    return decPass.toString();
  }
  void signUserIn(String name,String pass){
    String decP = decryptPassword(pass);
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '${name}@pratilipi.com', password: '${decP}'
    ).then((value){
      //Successfully signed in. Take user to the homepage.
      setState(() {
        isLoading = 0;
      });
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
            builder: (BuildContext context)=> new showStories(
              userDocs: value,
            )
        )
      );
    }).catchError((error){
      //Log the user out.
      setState(() {
        isLoading = 0;
      });
      FirebaseAuth.instance.signOut();
      setState(() {
        _error = "*There seems to be some problem while logging you in. Please try again later.*";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[

                //Heading
                Container(
                  margin: EdgeInsets.only(top:40,left:20.0, right:20.0, bottom: 10.0),
                  child: Center(
                    child: Text("Welcome to InfoBooks",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Playfair',
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0
                    ),),
                  ),
                ),

                SizedBox(height: 25.0,),

                DisplayPic(),
                SizedBox(height: 25.0,),

                Container(
                    margin: EdgeInsets.only(left:20.0,right:20.0),
                    child: inputField(value: _username,displayText: "Username",)
                ),

                SizedBox(height: 7.0,),

                Container(
                    margin: EdgeInsets.only(left:20.0,right: 20.0),
                    child: inputFieldPassword(pass: _password)
                ),

                SizedBox(height: 10.0,),

                (isLoading==0)?Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left:20.0,right: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: customButtons(isSecondary: 0,buttonText: 'Log in',),
                        onTap: (){
                          //logUserIn
                          String _un = _username.text.toString();
                          String _p = _password.text.toString();
                          if(_un.length!=0 && _p.length!=0){
                            setState(() {
                              isLoading = 1;
                            });
                            signUserIn(_un, _p);
                          }
                          else{
                            setState((){
                              _error = "*It seems like you missed some fields.Please fill in all the fields.*";
                            });
                          }
                        },
                      ),
                      //
                      SizedBox(width : 10.0,),

                      GestureDetector(
                          child: customButtons(isSecondary: 1,buttonText: 'Sign up',),
                          onTap: () {
                            //Send user to signup page
                            Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (BuildContext context)=>new SignUp()
                                )
                            );
                          }
                      ),
                    ],
                  ),
                ):Center(
                  child: AnimatedContainer(
                    curve: Curves.easeIn,
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/loading.gif'),
                        fit: BoxFit.fill
                      )
                    ),
                    duration: const Duration(milliseconds: 2000),
                  ),
                ),

                SizedBox(height: 10.0,),

                Container(
                  margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0),
                  child: Center(
                    child: Text('${_error}',
                      style: TextStyle(
                          color: Colors.redAccent
                      ),),
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