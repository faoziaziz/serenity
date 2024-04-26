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

StreamController<int> streamController = StreamController<int>();
Map<String, int> dictStats = {
  "admin": 0,
  "nurse": 1,
  "doctor": 2,
  "user": 4,
};

class HomePage extends StatefulWidget {

  final int? userNum;
  final String? user;


  const HomePage({this.user, required this.userNum});

  @override
  State<HomePage> createState() => _HomePageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _HomePageState extends State<HomePage> {

  /* Homepage state yang terpenting ada
  * */
  dynamic dataUsers;
  User currentUser = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  int choice_from_bot=0;
  int numuser=0;



  @override
  initState() {
    super.initState();
    //final user = await FirebaseAuth.instance.currentUser();
    // ignore: avoid_print
    // print("initState Called");
    if (FirebaseAuth.instance.currentUser != null) {
      print("User's email address: ${currentUser.email}");
      getStatusUser(currentUser.email);
      print("User's UID: ${currentUser.uid}");
      getStatusUser(currentUser.email);
    }
    

  }

  Future<void> getStatusUser(String? user) async {

    var snapshot = await users.doc(user).get().then(
        (DocumentSnapshot doc){


          setState(() {
            dataUsers = doc.data();
            

          });

        }
    );
    snapshot;

  }


  void setPagesFromBot(int choice){
    /* choose for home or account pages or others */
    setState(() {
      choice_from_bot=choice;
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
      body: Stack(
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text('title bar ${this.user}'),
              WhichUser(tipeUser: dictStats[dataUsers!['status']], botind: choice_from_bot,),
             Text("${currentUser.email}"),
             ElevatedButton(onPressed: (){
               // getStatusUser(currentUser.email);
               getStatusUser(currentUser.email);
               print("dataUsers :  ${dataUsers}");

             }, child: Text("Get Data")),
              Text("${dataUsers!['status']}"),
             Text("Code ${dictStats[dataUsers!['status']]}"),
             /*
              Text("List Pasientw"),
              Text("The Nurse : ${currentUser.email}"),

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

              */
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: NavbarBot(callbackFunc: setPagesFromBot,),
          ),
        ],
      ),
    );
  }
}

class WhichUser extends StatelessWidget {
  const WhichUser({this.stream, required this.tipeUser, required this.botind});
  final Stream<int>? stream;

  final int? tipeUser;
  final int botind; // bottombar index

  @override
  Widget build(BuildContext context) {
    if (tipeUser == 0) {
      return AdminScreen();
    } else if(tipeUser==1){
      return NursPage(choice: botind);
    }
    else if (tipeUser == 2) {
      return DoctorScreen();
    } else if (tipeUser == 3) {
      return NursPage(choice: botind);
    } else if (tipeUser == 4) {
      return UserScreen();
    }
    return Container();
  }
}
