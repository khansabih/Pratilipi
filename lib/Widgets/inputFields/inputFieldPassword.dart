import 'package:flutter/material.dart';

class inputFieldPassword extends StatefulWidget{
  final TextEditingController pass;

  const inputFieldPassword({Key key, this.pass}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new inputFieldPasswordState();
  }

}

class inputFieldPasswordState extends State<inputFieldPassword>{
  TextEditingController toBeReturned;

  int makeVisible = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      toBeReturned = widget.pass;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: toBeReturned,
      obscureText: (makeVisible==0)?true:false,
      decoration: InputDecoration(
          suffixIcon:(makeVisible==0)?GestureDetector(
              onTap: (){
                setState(() {
                  makeVisible = 1;
                });
              },
              child: Icon(Icons.visibility_off)
          ):GestureDetector(
              onTap: (){
                setState(() {
                  makeVisible = 0;
                });
              },
              child: Icon(Icons.visibility)
          ),
          border: OutlineInputBorder(
              borderSide : BorderSide(
                  color: Colors.black,
                  width: 5.0
              )
          ),
          hintText: "Password",
          hintStyle: TextStyle(
              fontFamily: 'Playfair',
              color: Colors.black
          ),
          labelText: "Password",
          labelStyle: TextStyle(
              fontFamily: 'Playfair',
              color: Colors.black
          ),
      ),
      style: TextStyle(
          color: Colors.black,
          fontFamily: 'Playfair',
          letterSpacing: 1.2,
          fontSize: 15.0,
          fontWeight: FontWeight.w500
      ),
    );
  }
}