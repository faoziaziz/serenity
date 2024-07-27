import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serenity/screens/nursery/widgets/VideoPlayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoListScreen extends StatefulWidget {
  final String category;
  const VideoListScreen({Key? key, required this.category}) : super(key: key);

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  static String videoID = 'egMWlD3fLJ8';
  late YoutubePlayerController _controller;
  bool isFullScreen = false;
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];


  /*
  *
  * */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("videos")
              .where("category", isEqualTo: widget.category)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("ada yang salah");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("lagi loding");
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                print(snapshot.data!);
                return GestureDetector(
                  onTap: () {
                    /* navigator context push */
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VideoSerenityPlayer(
                          url_video: data!["url"],
                          titleVideo: data!["title"],
                          description: data!["description"],
                        ),
                      ),
                    );
                  },
                  child: Card(child: _VideoButton(cardName: "${data!["title"]}")),
                );
              }).toList(),
            );
          }),

    );
  }

}

class _VideoButton extends StatelessWidget {
  const _VideoButton ({required this.cardName});

  final String cardName;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(child: Text(cardName, style: TextStyle(fontSize: 36),),),
    );
  }
}