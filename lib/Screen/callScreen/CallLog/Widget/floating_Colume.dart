import 'package:flutter/material.dart';
import 'package:karate_lecture/Util/UniversalVariable.dart';
class FloatingColume extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: UniversalVrialbes.fabGradint,
          ),
          child: Icon(
              Icons.dialpad,
            color: Colors.black,
            size: 25,

          ),
          padding: EdgeInsets.all(15),

        ),
        SizedBox(height:15  ,),
        Container(
          decoration:BoxDecoration
            (
            shape: BoxShape.circle,
            color: UniversalVrialbes.blackColor,
            border: Border.all(
              width: 2,
              color: UniversalVrialbes.gradientColorend,
            ),

          ),
          child: Icon(Icons.add_call,
          color: UniversalVrialbes.gradientColorend,size:
            25,),
padding: EdgeInsets.all(15),
        )
      ],
    );
  }
}
