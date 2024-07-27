/* username : Aziz Faozi
*  desc : main nursery pages */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serenity/providers/patientState.dart';
import 'VideoScreen.dart';
import 'streamNurse.dart';
import 'package:flutter/material.dart';
import 'package:serenity/screens/nursery/patient.dart';
import 'package:serenity/widgets/CounterProvider.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:serenity/providers/userState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class NurseryScreen extends StatefulWidget {
  // need to get status input
  final Function callbackFunction;

  const NurseryScreen({super.key, required this.callbackFunction});

  @override
  State<NurseryScreen> createState() => _NurseryScreenState();
}

class _NurseryScreenState extends State<NurseryScreen> {
  Future<Map<String, dynamic>> _getNurseDetails(String emailUsers) async {
    DocumentSnapshot ds = await FirebaseFirestore.instance
        .collection("users")
        .doc(emailUsers)
        .get();
    return ds.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<PatientState, UserState, ScreenState>(
        builder: (context, patState, userState, screenState, child) {
      return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // print(snapshot.data!.email);
              /* this line should change to future builder */
              return FutureBuilder(
                  /* i guess to get another items from firebase*/

                  future: _getNurseDetails(patState.stateUserOwner),
                  builder: (context, snapshot2) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Hi "),
                              Text(snapshot2.data != null
                                  ? snapshot2.data!["full_name"]
                                  : "User"),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => VideoScreen()
                                    ),
                                  );

                                  screenState.changeStateNurse(4);
                                },
                                child: Card(
                                  child: _YourVideo(
                                    cardName: "Your Videos",
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  screenState.changeStateNurse(5);
                                },
                                child: Card(
                                  child: _YourVideo(
                                    cardName: "Your Audio",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    screenState.changeStateNurse(6);
                                  },
                                  child: Card(
                                    child: _YourVideo(
                                      cardName: "All About Stroke",
                                    ),
                                  )),
                              GestureDetector(
                                onTap: () {
                                  screenState.changeStateNurse(1);
                                },
                                child: Card(
                                  child: _YourVideo(
                                    cardName: "Your Patient",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
            return CircularProgressIndicator();
          });
    });
    ;
  }
}

class _YourVideo extends StatelessWidget {
  const _YourVideo({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 40,
      height: MediaQuery.of(context).size.height / 2 - 300,
      child: Center(child: Text(cardName)),
    );
  }
}
