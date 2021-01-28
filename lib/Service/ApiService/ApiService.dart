
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:karate_lecture/Setting/setting.dart';

import 'package:karate_lecture/model/channal.dart';
import 'package:karate_lecture/model/video.dart';



class APIService{
  APIService._instantiate();
  static final APIService instance=APIService._instantiate();
  final String _baseUrl='www.googleapis.com';
  String _nextPageToken='';

  Future<Channel> fetchChannel({String channelId})async{
    Map<String,String>parameter= {
      'part':'snippet,contentDetails,statistics',
      'id':channelId,
      'key':Youtube_api_key
    };
    Uri uri= Uri.https(_baseUrl,
        '/youtube/v3/channels',
      parameter
    );
    Map<String,String>headers= {
      HttpHeaders.contentTypeHeader:'application/json',

    };
    //TODO: get Channal
    var response=await http.get(uri,headers:headers);
     if(response.statusCode==200){
       Map<String,dynamic>data=await json.decode(response.body)['items'][0];
       Channel channel=  Channel.fromMAp(data);
       //TODO: Fetch batch of video from upload playlist
       channel.videos=await fetchVideoFromPlaylist(
         playlistId:channel.uploadPlaylistId,
       );
       return channel;

     }else{

       throw json.decode(response.body)['error']['message'];

     }




  }
  Future<List<Video>> fetchVideoFromPlaylist({String playlistId})async{
    Map<String,String>parameters=  {
      'part':'snippet',
      'playlistId':playlistId,
      'maxResults':'8',
      'pageToken':_nextPageToken,
      'key':Youtube_api_key,
    };
    Uri uri= Uri.https
      (_baseUrl,
        '/youtube/v3/playlistItems',
    parameters);
    Map<String,String>headers={
      HttpHeaders.contentTypeHeader:'application/json',
    };
    var response=await http.get(uri,headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _nextPageToken = data['nextPageToken'] ?? '';
        List<dynamic> videosJson = data['items'];

        //Todo: Fetch first eight video from upload playlist
        List<Video> videos = [];
        videosJson.forEach((json) =>
            videos.add(
              Video.fromMap(json['snippet']),
            ));
        if(videos.isEmpty){
          print('error jay iny');
        }else{
          print(videos.length);
        }
     videos.sort((a,b)=>a.toString().length.compareTo(b.toString().length));

        return videos;

      } else {
        throw json.decode(response.body)['error']['message'];
      }

  }

}