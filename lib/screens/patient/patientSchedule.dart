import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serenity/providers/patientState.dart';
import 'package:provider/provider.dart';

class PatientSchedule extends StatefulWidget {
  const PatientSchedule({super.key});

  @override
  State<PatientSchedule> createState() => _PatientScheduleState();
}

Future<Object?> _getAudioDetails(String idAudio) async {
  //print("CHeckin audio ${idAudio}");
  DocumentSnapshot ds =
  await FirebaseFirestore.instance.collection('audio').doc(idAudio).get();
  return ds.data();

}

class _PatientScheduleState extends State<PatientSchedule> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientState>(
      builder: (context, patState, child) {
        return Column(
          children: [
            const Text("Jadwal Audio Kamu"),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(patState.stateUserOwner)
                    .collection("jadwal")
                    .snapshots(),
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    print(snapshot2.data!.docs.length);
                    return SizedBox(
                      height: 300,
                      //width: 200,
                      child: ListView.builder(
                          itemCount: snapshot2.data!.docs.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 200,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      "${snapshot2.data!.docs[index].get("jam")}"),
                                  SizedBox(width: 10,),
                                  SizedBox(
                                    width: 200,
                                    child: FutureBuilder(
                                        future: _getAudioDetails(snapshot2.data!.docs[index].get("audio").toString()),
                                        builder: (context, snapshot4) {
                                          if (snapshot4.hasError){
                                            return Text("error");
                                          }
                                          if (snapshot4.hasData){
                                            Map<String, dynamic> data4 =
                                            snapshot4.data! as Map<
                                                String, dynamic>;
                                            print(
                                                "text : ${snapshot4.data!}");
                                            return Text(
                                                "${data4["title"]}");
                                          }
                                          return const CircularProgressIndicator();

                                          // Text("${snapshot.data!.docs[index].get("audio")}");
                                        }),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }

                  if (snapshot2.hasError) {
                    return Text("Error");
                  } else {
                    return const CircularProgressIndicator();
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        );
      }
    );
  }
}
