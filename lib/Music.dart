import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/model/channel_info.dart';
import 'package:vhelp_test/model/videos_list.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/screens/video_player_podcast.dart';
import 'package:vhelp_test/utils/services.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    print(_loading.toString());
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
                    iconTheme: IconThemeData(color: Colors.black54),
                    backgroundColor: Colors.blue.shade100,
                    elevation: 0,
                    actions: [
                      LanguagePickerWidget(),
                      //const SizedBox(width: 12),
                    ],
                    title: Text(
                        _loading
                            ? S.of(context)!.loading
                            : S.of(context)!.sidebar7,
                        style: TextStyle(color: Colors.black54, fontSize: 22)),
                  ),
                  body: Container(
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.blue.shade100,
                          Colors.blue.shade100
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.center,
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
            child: NoInternet(),
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
                        S.of(context)!.playlist_name,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ),
                    Text(
                      _item.statistics.videoCount,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          );
  }
}
