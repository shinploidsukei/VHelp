import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/model/channel_info.dart';
import 'package:vhelp_test/model/videos_list.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/screens/video_player_podcast.dart';
import 'package:vhelp_test/utils/services.dart';

// ignore: camel_case_types
class music extends StatefulWidget {
  @override
  _Music createState() => _Music();
}

class _Music extends State<music> {
  late ChannelInfo _channelInfo;
  late VideoList _videoList;
  late Item _item;
  late bool _loading;
  late String _playListId;
  late String _nextPageToken;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videoList = VideoList(
        etag: '', kind: '', nextPageToken: '', pageInfo: null, videos: []);
    // ignore: deprecated_member_use
    //_videoList.videos = ListView();
    _getChannelInfo();
  }

  _getChannelInfo() async {
    _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo.items[0];
    _playListId = _item.contentDetails.relatedPlaylists.uploads;
    print('_playListId $_playListId');
    await _loadVideos();
    setState(() {
      _loading = false;
    });
  }

  _loadVideos() async {
    VideoList tempVideosList = await Services.getVideosList(
      playListId: _playListId,
      pageToken: _nextPageToken,
    );
    _nextPageToken = tempVideosList.nextPageToken!;
    _videoList.videos.addAll(tempVideosList.videos);
    print('videos: ${_videoList.videos.length}');
    print('_nextPageToken $_nextPageToken');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? Scaffold(
                  appBar: AppBar(
                    title: Text(_loading ? 'Loading...' : 'Music Therapy'),
                  ),
                  body: Container(
                    color: Colors.blueGrey[100],
                    child: Column(
                      children: [
                        _buildInfoView(),
                        Expanded(
                          child: NotificationListener<ScrollEndNotification>(
                            onNotification: (ScrollNotification notification) {
                              if (_videoList.videos.length >=
                                  int.parse(_item.statistics.videoCount)) {
                                return true;
                              }
                              if (notification.metrics.pixels ==
                                  notification.metrics.maxScrollExtent) {
                                _loadVideos();
                              }
                              return true;
                            },
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: _videoList.videos.length,
                                itemBuilder: (context, index) {
                                  VideoItem videoItem =
                                      _videoList.videos[index];
                                  return InkWell(
                                    onTap: () async {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return VideoPlayerScreen(
                                            videoItem: videoItem);
                                      }));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20.0),
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: videoItem.video.thumbnails
                                                .thumbnailsDefault.url,
                                          ),
                                          SizedBox(width: 20),
                                          Flexible(
                                              child:
                                                  Text(videoItem.video.title)),
                                          SizedBox(width: 20),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : NoInternet();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  _buildInfoView() {
    return _loading
        ? CircularProgressIndicator()
        : Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        _item.snippet.thumbnails.medium.url,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        _item.snippet.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(_item.statistics.videoCount),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          );
  }
}
