import 'package:flutter/material.dart';
import 'package:karate_lecture/SearchScreen/SearchScreen.dart';
import 'package:karate_lecture/Util/UniversalVariable.dart';

class OurQuiteBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "this is where all the contact are listed",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Search for your friend and family to start colling and chatting with them",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FlatButton(
                color: UniversalVrialbes.lightblueColor,
                child: Text("START SEARCHING"),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OurSearchScreen())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
