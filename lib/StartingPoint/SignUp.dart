import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pratilipi/Widgets/DisplayPicture/DisplayPic.dart';
import 'package:pratilipi/Widgets/inputFields/inputField.dart';
import 'package:pratilipi/Widgets/inputFields/inputFieldPassword.dart';
import 'package:pratilipi/Widgets/myButtons/customButtons.dart';
import 'LogIn.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SignUpState();
  }

}

class SignUpState extends State<SignUp>{

  TextEditingController username = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String errMsg = "";

  int signingUp = 0;

  String encryptPassword(String passwrd){
      var bytes = utf8.encode(passwrd);
      var encPass = sha256.convert(bytes);
      return encPass.toString();
  }

  void signUpTheUser(String userName, String password){
    String encP = encryptPassword(password);
    print("$password = $encP");
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "${userName}@pratilipi.com", password: encP).then((userValues){
          //Put the user in the your databse.
          FirebaseFirestore.instance.collection('Users')
              .doc('${userValues.user.uid}').set({
              'username' : userName,
              'userId' : userValues.user.uid
          }).whenComplete((){
            setState(() {
              signingUp=0;
            });
            //Send back to the login page
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              new MaterialPageRoute(
                  builder:(BuildContext context) => new Login()
              )
            );
          }).catchError((error){
            setState(() {
              signingUp = 0;
            });
            //Stop the process. Delete the user credentials
            FirebaseAuth.instance.currentUser.delete().whenComplete((){
              //Empty the textfields for new info to come in
              setState(() {
                username.text = "";
                pass.text = "";
                errMsg = "*There seems to be some problem.Please try again.*";
              });
            });
          });
      }).catchError((error){
        setState(() {
          signingUp = 0;
        });
       //Stop the registration if there is any problem.
      FirebaseAuth.instance.currentUser.delete().whenComplete((){
        //Empty the textfields for new info to come in
        setState(() {
          username.text = "";
          pass.text = "";
          errMsg = "*There seems to be some problem.Please try again.*";
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: ListView(
              // mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                //Heading
                Container(
                  margin: EdgeInsets.only(top:40,left:20.0, right:20.0, bottom: 10.0),
                  child: Center(
                    child: Text("Create an account",
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

                inputField(value: username,displayText: 'Make a username',),

                SizedBox(height: 7.0,),

                inputFieldPassword(pass: pass,),

                SizedBox(height: 10.0,),

                (signingUp==0)?GestureDetector(
                  child: customButtons(isSecondary: 0,buttonText: 'Register',),
                  onTap: (){
                    //sign up the user
                    String uname = username.text.toString();
                    String pword = pass.text.toString();
                    if(pword.length!=0 && uname.length!=0){
                      setState(() {
                        signingUp=1;
                      });
                      signUpTheUser(uname, pword);
                    }
                    else{
                      setState(() {
                        errMsg = "*It seems you have left some fields blank.*";
                      });
                    }
                  },
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
                    child: Text('${errMsg}',
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