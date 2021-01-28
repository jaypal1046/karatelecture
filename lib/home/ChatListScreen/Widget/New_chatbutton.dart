import 'package:flutter/material.dart';
import 'package:karate_lecture/SearchScreen/SearchScreen.dart';
class NewChatButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 213, 235, 220),
       border: Border.all(width: 1),


      ),
      child: GestureDetector(
        onTap: ()=> Navigator.push(
            context, MaterialPageRoute(
          builder: (_) =>
              OurSearchScreen(
              ),
        )
        ),

        child:Padding(padding:  EdgeInsets.all(15),
          child:
          Icon(
            Icons.edit,

            color: Colors.black87,
            size: 25,


          ),
      ),
      )

      );

  }
}