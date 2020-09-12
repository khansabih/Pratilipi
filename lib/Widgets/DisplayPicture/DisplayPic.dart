import 'package:flutter/material.dart';

class DisplayPic extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/books2.jpg'),
            fit: BoxFit.fill
          ),
          color: Colors.black.withOpacity(0.6)
        ),
      ),
    );
  }

}