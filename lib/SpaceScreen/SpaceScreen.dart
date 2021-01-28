import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class OurSpaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.black87,
        ),
      ),
    );

  }
}
