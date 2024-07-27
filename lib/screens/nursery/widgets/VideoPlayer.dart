import 'package:flutter/material.dart';
/* ini untuk player video */
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
class VideoSerenityPlayer extends StatefulWidget {
  final String url_video;
  final String titleVideo;
  final String description;
  const VideoSerenityPlayer({super.key, required this.url_video, required this.titleVideo, required this.description});

  @override
  State<VideoSerenityPlayer> createState() => _VideoSerenityPlayerState();
}

class _VideoSerenityPlayerState extends State<VideoSerenityPlayer> {

  /* variable declarations */
  static String videoID = 'CTCfeaZ2p7I';
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late YoutubePlayerController _controller;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume=100;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool isFullScreen = false;
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  final List<String> _ids = [
    'rMbATaj7Il8',
    'DPL_SV3n7IU'

  ];
  @override
  void initState() {
    super.initState();
    setState(() {

    });
    
    _controller = YoutubePlayerController(
      initialVideoId: widget.url_video,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController=TextEditingController();
    _seekToController=TextEditingController();
    _videoMetaData= const YoutubeMetaData();
    _playerState=PlayerState.unknown;


    /*
    _controller.addListener(() {
      if (_controller.value.isFullScreen != isFullScreen) {
        setState(() {
          isFullScreen = _controller.value.isFullScreen;
        });
      }
    });
    */
  }

  void listener(){
    if(_isPlayerReady&&mounted&&!_controller.value.isFullScreen){
      setState(() {
        _playerState=_controller.value.playerState;
        _videoMetaData=_controller.metadata;
      });

    }

  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.titleVideo),
      ),
      body: YoutubePlayerBuilder(
        onExitFullScreen: () {
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          setState(() {
            isFullScreen = false;
          });
        },

        player: YoutubePlayer(
          controller: _controller,
          liveUIColor: Colors.amber,
          showVideoProgressIndicator: true,
          bottomActions: [
            CurrentPosition(),
            const SizedBox(width: 10.0,),
            ProgressBar(isExpanded: true,),
            const SizedBox(width: 10.0,),
            RemainingDuration(),
            FullScreenButton(),

          ],
        ),
        builder: (context, player)=> Scaffold(
          body: ListView(children: [
            player,
            Padding(
                padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(widget.description),
                ],
              ),
            ),

          ],),
        ),
      ),
    );
  }
}
