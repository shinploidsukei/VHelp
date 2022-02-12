import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:vhelp_test/main.dart';

AssetsAudioPlayer _assetsAudioPlayer = new AssetsAudioPlayer();

class SoundPickerWidget extends StatefulWidget {
  const SoundPickerWidget({Key? key}) : super(key: key);

  @override
  _SoundPickerWidgetState createState() => _SoundPickerWidgetState();

  void LoopAudio() {
    _assetsAudioPlayer.open(
      Audio("assets/sounds/BGM_SBA-346465804.mp3"),
      autoStart: true,
      loopMode: LoopMode.single,
    );
  }
}

class _SoundPickerWidgetState extends State<SoundPickerWidget> {
  bool click = true;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: new EdgeInsets.all(0.0),
        icon: new Icon(
            (click == false)
                ? Icons.circle_notifications_outlined
                : Icons.circle_notifications,
            size: 30.0),
        onPressed: () {
          setState(() {
            click = !click;
            if (click == true) {
              //  _assetsAudioPlayer = AssetsAudioPlayer();
              _assetsAudioPlayer.open(
                Audio("assets/sounds/BGM_SBA-346465804.mp3"),
                autoStart: true,
                loopMode: LoopMode.single,
              );
            } else {
              _assetsAudioPlayer.stop();
            }
          });
        });
  }
}
