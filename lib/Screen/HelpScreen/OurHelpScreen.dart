import 'package:flutter/material.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
class OurHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
        title: Text('Help'),
      ),

      body: SingleChildScrollView(
        child: OurContener(
          child: Column(
            children: <Widget>[
              Text('To get channel id you need to first goto',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              Text('\n https://www.youtube.com',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              Text('\n Sign in to YouTube',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              Text('\n In the top right, click your profile picture and then Settings',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              Text('\n From the left Menu, select Advanced settings.',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              Text('\n You’ll see your channel’s user and channel IDs.',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
              Text(  '\n OR',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
              Text(  '\n There is the simplest way to find the channel ID of any YouTube channel !!',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),

              Text('\nStep 1: Play a video of that channel.',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),

              Text( '\nStep 2: Click the channel name under that video.',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),

              Text('\nStep 3: Look at the browser address bar.',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),



            ],
          ),
        ),
      )
    );
  }
}
