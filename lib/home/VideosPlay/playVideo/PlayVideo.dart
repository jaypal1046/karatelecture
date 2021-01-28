import 'package:flutter/material.dart';
import 'package:karate_lecture/model/channal.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class VideoScreen extends StatefulWidget {
  final String id;
  final String title;
  Channel channel;
  VideoScreen({
    this.title,
    this.channel,
    this.id,
  });
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;
  bool _isPlayerReady;
  @override
  void initState() {
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
        initialVideoId: widget.id,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
        ))
      ..addListener(_listerner);
  }

  void _listerner() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {}
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "widget.title",
        home: Container(
          alignment: Alignment.center,
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
              _isPlayerReady = true;
            },
          ),
        ));
  }
}
