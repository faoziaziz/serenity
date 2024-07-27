import 'package:flutter/material.dart';
import 'package:serenity/screens/nursery/widgets/VideoList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serenity/screens/nursery/widgets/addVideo.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Video"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("cat_videos").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("ada yang salah");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoListScreen(
                            category: data!['category'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Text(data!['category']),
                    ),
                  );
                }).toList(),
              );
            }
            return CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // buka page baru buat nambahin video
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Addvideo(),
            ),
          );
        },
        tooltip: 'Update Text',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _VideoCategory extends StatelessWidget {
  const _VideoCategory({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: Text(
        cardName,
        style: TextStyle(fontSize: 36),
      )),
    );
  }
}
