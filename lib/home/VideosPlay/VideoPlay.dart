import 'package:flutter/material.dart';
import 'package:karate_lecture/Service/ApiService/ApiService.dart';
import 'package:karate_lecture/Widget/OurContener.dart';
import 'package:karate_lecture/home/VideosPlay/playVideo/PlayVideo.dart';
import 'package:karate_lecture/model/channal.dart';
import 'package:karate_lecture/model/video.dart';

// ignore: must_be_immutable
class OurVideoScreen extends StatefulWidget {
  Channel channel;
  OurVideoScreen({
    this.channel,
  });
  @override
  _OurVideoScreenState createState() => _OurVideoScreenState();
}

class _OurVideoScreenState extends State<OurVideoScreen> {
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    // Channel channel=await APIService.instance.fetchChannel(channelId: 'UC6Dy0rQ6zDnQuHQ1EeErGUA');
    //Channel channal1 =await APIService.instance.fetchChannel(channelId:'UC6Dy0rQ6zDnQuHQ1EeErGUA');
    setState(() {
      _channel = widget.channel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${_channel.title} Videos'),
        ),
        body: _channel != null
            ? NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollDetail) {
                  if (!_isLoading &&
                      _channel.videos.length !=
                          int.parse(_channel.videoCount)) {
                    _loadMoreVideo();
                  }
                  return false;
                },
                child: ListView.builder(
                    itemCount: _channel.videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      // if(index==0){
                      //  return _builderProfileInfo();
                      // }
                      Video video = _channel.videos[index];
                      return _builderVideo(video);
                    }),
              )
            : Center(
                child: CircularProgressIndicator(),
                // child: Text('loading'),
              ));
  }

  _loadMoreVideo() async {
    _isLoading = true;
    List<Video> moreVideo = await APIService.instance
        .fetchVideoFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideo = _channel.videos..addAll(moreVideo);
    setState(() {
      _channel.videos = allVideo;
    });
    _isLoading = false;
  }

  // ignore: unused_element
  _builderProfileInfo() {
    return OurContener(
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel.subscriberCount} Subscription',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _builderVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => VideoScreen(
                  id: video.id, channel: _channel, title: video.title))),
      child: OurContener(
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
