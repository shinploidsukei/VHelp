import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:vhelp_test/model/channel_info.dart';
import 'package:vhelp_test/model/videos_list.dart';
import 'package:vhelp_test/utils/constant.dart';

class Services {
  static const CHANNEL_ID = 'UCLaUaVhZptelTv3hHKKPkiA';
  static const _baseUrl = "www.googleapis.com";

  static Future<ChannelInfo> getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/channels', parameters);
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    print("PloyChannel: $channelInfo ");
    return channelInfo;
  }

  static Future<VideoList> getVideosList(
      {required String playListId, required String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/playlistItems', parameters);
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    VideoList videosList = videoListFromJson(response.body);
    return videosList;
  }
}
