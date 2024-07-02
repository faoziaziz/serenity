import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:serenity/screens/adminscreen.dart';
import 'package:serenity/screens/doctorscreen.dart';
import 'package:serenity/screens/nurspage.dart';
import 'package:serenity/screens/userscreen.dart';
import 'package:serenity/widgets/LoginScreen.dart';
import 'package:serenity/widgets/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serenity/screens/navBarBot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serenity/models/users.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/patientState.dart';

StreamController<int> streamController = StreamController<int>();
Map<String, int> dictStats = {
  "admin": 0,
  "nurse": 1,
  "doctor": 2,
  "user": 3,
};

class HomePage extends StatefulWidget {


  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _HomePageState extends State<HomePage> {
  /* Homepage state yang terpenting ada
  * */
  bool _loading =true;
  dynamic dataUsers;
  //User currentUser = FirebaseAuth.instance.currentUser!;
  //CollectionReference users = FirebaseFirestore.instance.collection('users');
  int choice_from_bot = 0;
  int numuser = 0;

  Future<Object?> _getDataUser (String docId) async {
    DocumentSnapshot datUs = await FirebaseFirestore.instance.collection("users").doc(docId).get();
    return datUs.data();
  }

  @override
  initState() {
    super.initState();
    //final user = await FirebaseAuth.instance.currentUser();
    // ignore: avoid_print
    // print("initState Called");
    if (FirebaseAuth.instance.currentUser != null) {



      setState(() {
        _loading=false;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          var patState = Provider.of<PatientState>(context, listen: false);
          patState.changeStateUserOwner(FirebaseAuth.instance.currentUser!.email.toString());
        });
      });
    }
  }



  void setPagesFromBot(int choice) {
    /* choose for home or account pages or others */
    setState(() {
      choice_from_bot = choice;
      print("coice form bot ${choice}");
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Serenity Home'),
        centerTitle: true,
      ),
      body: Consumer<PatientState>(
        builder: (context, patState, child) {
          return FutureBuilder(
            future: _getDataUser(FirebaseAuth.instance.currentUser!.email.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return Text("lagi error");

              }
              if (snapshot.hasData){
                Map<String, dynamic> dataHome =
                snapshot.data! as Map<String, dynamic>;




                return Stack(
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         WhichUser(tipeUser: dictStats[dataHome['status']], botind: dictStats[dataHome['status']],),

                        ElevatedButton(
                            onPressed: () {
                              AuthService().signOut();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text('Log out'))


                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: NavbarBot(
                        callbackFunc: setPagesFromBot,
                        bottomChoiced: dictStats[dataHome['status']],
                      ),
                    ),
                  ],
                );


              }


              return Stack(
                children: [
                  CircularProgressIndicator(),
                ],
              );
            }
          );
        }
      ),
    );
  }
}

class WhichUser extends StatelessWidget {
  const WhichUser({this.stream, required this.tipeUser, required this.botind});
  final Stream<int>? stream;

  final int? tipeUser;
  final int? botind; // bottombar index

  @override
  Widget build(BuildContext context) {
    if (tipeUser == 0) {
      return AdminScreen();
    } else if (tipeUser == 1) {
      return NursPage(choice: botind);
    } else if (tipeUser == 2) {
      return DoctorScreen();
    }  else if (tipeUser == 3) {
      return UserScreen();
    }
    return Container();
  }
}
