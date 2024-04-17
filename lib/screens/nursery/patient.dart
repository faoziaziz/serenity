import 'dart:async';
import 'package:flutter/material.dart';
import 'package:serenity/widgets/LoginScreen.dart';
import 'package:serenity/widgets/homepage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'streamNurse.dart';

class UserNurseryScreen extends StatefulWidget {
  final Function cbFunc;
  const UserNurseryScreen({super.key, required this.cbFunc});


  @override
  State<UserNurseryScreen> createState() => _UserNurseryScreenState();
}

class _UserNurseryScreenState extends State<UserNurseryScreen> {

  final player = AudioPlayer();

  Future<void> playAudioFromUrl(String url) async {
    await player.play(UrlSource(url));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text(
            "Medical Analitycs",
          ),
          Text("list of todo 1"),
          Text("List of todo 2"),
          ElevatedButton(
            onPressed: () {
              playAudioFromUrl(
                  'https://raw.githubusercontent.com/rafaelreis-hotmart/Audio-Sample-files/master/sample2.mp3');
            },
            child: Text("Play Audio"),
          ),
          ElevatedButton(
            onPressed: () {
              //player.stop();
              print("clicked");

            },
            child: Text("Stop"),
          ),
          ElevatedButton(
            onPressed: () {
              //player.stop();
             widget.cbFunc(0);

            },
            child: Text("Stop"),
          ),
        ],
      );
  }
}
