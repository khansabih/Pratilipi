import 'package:flutter/material.dart';

class customButtons extends StatelessWidget{
  final int isSecondary;
  final String buttonText;

  const customButtons({Key key, this.isSecondary, this.buttonText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top:10.0),
      height: 50.0,
      width: 130.0,
      decoration: BoxDecoration(
          color: (isSecondary==0)?Colors.black:Colors.white,
          border: Border.all(
              color: Colors.black
          )
      ),
      child: Center(
        child: Text('$buttonText',
          style: TextStyle(
              fontSize: 18.0,
              color: (isSecondary==0)?Colors.white:Colors.black,
              fontFamily: 'Playfair'
          ),),
      ),
    );
  }

}