import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_lecture/Widget/cached_image.dart';
import 'package:karate_lecture/model/massage.dart';
import 'package:photo_view/photo_view.dart';
import '';
class OurImageView extends StatefulWidget {
  OurMessage message;
  OurImageView(this.message);

  @override
  _OurImageViewState createState() => _OurImageViewState();
}

class _OurImageViewState extends State<OurImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Material(

        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(
              widget.message.photoUrl
          ),
        ),
      ),
    );

  }
}
