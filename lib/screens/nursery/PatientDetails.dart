import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/patientState.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:serenity/screens/nursery/widgets/PatientHealthStatus.dart';
import 'package:serenity/screens/nursery/widgets/assignAudio.dart';





class PatientDetails extends StatefulWidget {
  final String userid;
  const PatientDetails({super.key, required this.userid});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  //var userid = widget.userid;
  bool assignAudio = true;
  /*getting methode 2 from firestore*/

  Future<Object?> _getDataFirebase(String docid) async {
    DocumentSnapshot ds =
    await FirebaseFirestore.instance.collection('users').doc(docid).get();
    return ds.data();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getDataFirebase2(String docid) async {
    QuerySnapshot<Map<String, dynamic>> ds =
    await FirebaseFirestore.instance.collection('users').doc(docid).collection("jadwal").get();
    return ds;
  }

  Future<Object?> _getAudioDetails(String idAudio) async {
    //print("CHeckin audio ${idAudio}");
    DocumentSnapshot ds =
    await FirebaseFirestore.instance.collection('audio').doc(idAudio).get();
    return ds.data();

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PatientState, ScreenState>(
        builder: (context, patientState, screenState, child) {
      return FutureBuilder(
          future: _getDataFirebase(patientState.stateUserID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              /* this is they key of mapping input */
              Map<String, dynamic> data2 =
                  snapshot.data! as Map<String, dynamic>;


              return Column(
                children: [
                  Text("${data2["full_name"]}"),
                  Text("${data2["ttl"]}"),
                  Text("${data2["email"]}"),
                  assignAudio
                      ? AssignAudio()
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              assignAudio = true;
                            });
                          },
                          child: Text("Assign Audio"),
                        ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(patientState.stateUserID)
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

                        if (snapshot.hasError) {
                          return Text("Error");
                        } else {
                          return const CircularProgressIndicator();
                        }
                        return const CircularProgressIndicator();
                      }),

                  PatientHealtStatus(),

                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          });
      //Text("${widget.userid}");
    });
  }
}
