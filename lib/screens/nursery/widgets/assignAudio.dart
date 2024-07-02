import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/patientState.dart';

class AssignAudio extends StatefulWidget {
  const AssignAudio({super.key});

  @override
  State<AssignAudio> createState() => _AssignAudioState();
}

class _AssignAudioState extends State<AssignAudio> {
  String? urlAudio;
  String? idDocs;
  String titleAudio = "Pilih Audio";
  bool? isPlaying;
  late AudioPlayer audioPlayer;
  int? selectedIndex;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _timeC = TextEditingController();

  TimeOfDay timeOfDay = TimeOfDay.now();

  Future<DocumentSnapshot> getQuestionFromFirebase(String documentId) async {
    return await _firestore.collection('audio').doc(documentId).get();
  }

  Future<Object?> questionMapFromFirebase(String documentId) async {
    DocumentSnapshot ds = await getQuestionFromFirebase(documentId);
    return ds.data();
  }

  void _addJadwalAudio(String user, String waktuPemutaran, String idAudio){
    var db = FirebaseFirestore.instance.collection("users").doc(user).collection("jadwal");

    db.add({
      "audio": idAudio,
      "jam": waktuPemutaran,
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPlaying = false;
    audioPlayer = AudioPlayer();
    selectedIndex = -1;
    titleAudio = "Pilih Audio";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientState>(
      builder: (context, patState, child) {
        return ListView(
          shrinkWrap: true,
          children: [
            ElevatedButton(
                onPressed: () => displayTimePicker(context),
                child: Text("${_timeC.text.isEmpty ? "Set Waktu" : _timeC.text}")),
            ElevatedButton(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("audio")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                //return Text("ada data : ${snapshot.data!.docs.length}");

                                return SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            //snapshot.data!.docs[index].reference.id.toString(),
                                            snapshot.data!.docs[index].get("title"),
                                            //"Hai"
                                          ),
                                          subtitle: Text(snapshot.data!.docs[index].get("url")),
                                          onTap: () {
                                            setState(() {
                                              idDocs = snapshot
                                                  .data!.docs[index].reference.id
                                                  .toString();
                                              titleAudio = snapshot
                                                  .data!.docs[index]
                                                  .get("title");
                                              urlAudio = snapshot.data!.docs[index]
                                                  .get("url");
                                              Navigator.pop(context);
                                            });
                                            //_checkPlayAudio(snapshot
                                            //    .data!.docs[index]
                                            //     .get("url"));
                                          },
                                        );
                                      }),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Text("error");
                              } else {
                                return const CircularProgressIndicator();
                              }
                            }),
                      ),
                    ),
                  );
                },
                child: Text(titleAudio)),
            urlAudio != null
                ? ElevatedButton(
                    onPressed: () {
                      _checkPlayAudio(urlAudio!);
                    },
                    child: Text("play audio"))
                : Padding(padding: EdgeInsets.all(10)),
            _timeC.text.isNotEmpty&&idDocs.toString()!="null"? ElevatedButton(onPressed: (){
              _addJadwalAudio(patState.stateUserID, _timeC.text, idDocs.toString());
            }, child: Text("Tambahkan Jadwal")): SizedBox(),


            // Schedule
            Text(
              "Schedule",
              textAlign: TextAlign.center,
            ),


          ],
        );
      }
    );
  }

  Future<void> _checkPlayAudio(String url) async {
    await audioPlayer.play(UrlSource(url));
  }

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      setState(() {
        _timeC.text = "${time.hour}:${time.minute}";
      });
    }
  }
}
