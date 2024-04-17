import 'dart:async';
import 'package:flutter/material.dart';
import 'package:serenity/screens/adminscreen.dart';
import 'package:serenity/screens/doctorscreen.dart';
import 'package:serenity/screens/nurspage.dart';
import 'package:serenity/screens/userscreen.dart';
import 'package:serenity/widgets/LoginScreen.dart';
import 'package:serenity/widgets/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serenity/screens/navBarBot.dart';


StreamController<int> streamController = StreamController<int>();

class HomePage extends StatefulWidget {
  final String? user;
  final Stream<int>? stream;

  const HomePage({this.user, this.stream});

  @override
  State<HomePage> createState() => _HomePageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _HomePageState extends State<HomePage> {
  User currentUser = FirebaseAuth.instance.currentUser!;

  int choice_from_bot=0;

  @override
  initState() {
    //final user = await FirebaseAuth.instance.currentUser();
    // ignore: avoid_print
    print("initState Called");
    if (FirebaseAuth.instance.currentUser != null) {
      print("User's email address: ${currentUser.email}");
      print("User's UID: ${currentUser.uid}");

    }


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
              WhichUser(tipeUser: 1, botind: choice_from_bot,),
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

  final int tipeUser;
  final int botind; // bottombar index

  @override
  Widget build(BuildContext context) {
    if (tipeUser == 1) {
      return AdminScreen();
    } else if (tipeUser == 2) {
      return DoctorScreen();
    } else if (tipeUser == 3) {
      return NursPage(choice: botind);
    } else if (tipeUser == 4) {
      return UserScreen();
    }
    return Container();
  }
}
