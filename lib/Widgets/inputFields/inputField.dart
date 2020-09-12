import 'package:flutter/material.dart';

class inputField extends StatefulWidget{
  final TextEditingController value;
  final String displayText;

  const inputField({Key key, this.value, this.displayText}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new inputFieldState();
  }

}

class inputFieldState extends State<inputField>{
  TextEditingController toBeReturned;


  @override
  void initState() {
    super.initState();
    setState(() {
      toBeReturned = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: toBeReturned,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide : BorderSide(
              color: Colors.black,
              width: 5.0
            )
          ),
          hintText: "${widget.displayText}",
          hintStyle: TextStyle(
              fontFamily: 'Playfair',
              color: Colors.black
          ),
          labelText: "Username",
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