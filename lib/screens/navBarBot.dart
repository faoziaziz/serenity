/*
*   notes : home page untuk serenity
* */

import 'package:flutter/material.dart';
import 'package:serenity/screens/admin/adminBotBar.dart';

import '../widgets/homepage.dart';
import 'nursery/NurserBotBar.dart';


List<IconData> navIcons = [
  Icons.home,
  Icons.wallet,
  Icons.person,
];

List<String> navTitle = [
  "Home",
  "Wallet",
  "Account",
];




class NavbarBot extends StatefulWidget {

  final Function callbackFunc;

  const NavbarBot({super.key, required this.callbackFunc});

  @override
  State<NavbarBot> createState() => _NavbarBotState();
}

class _NavbarBotState extends State<NavbarBot> {

  /* local variable */

  int selectedPage= 0;
  int bottomSelected = 0;

  @override
  void initState() {
    // TODO: implement initState

    // Should selected page compactible with pages of type user
    selectedPage = 0;
    super.initState();
  }

  void setBottom(int bot_choice){
    setState(() {
      bottomSelected=bot_choice;
      widget.callbackFunc(bottomSelected);
      print("terpilih bot ${bottomSelected}");
    });
    
  }


  @override
  Widget build(BuildContext context) {

    /* selected page will coiced the bottom */
    switch(selectedPage){
      case 0 : return AdminBotBar();
      case 1 : return NurseryBotBarSTFULL(callBackFunction: setBottom,);
      case 2 : return bottomDoctor();
    }

    return bottomNursery(context);
  }
}




Widget bottomNursery (BuildContext context){
  return Container(
    height: 65,
    margin: EdgeInsets.only(
      right: 24,
      left: 24,
      bottom: 24,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 20,
          spreadRadius: 10,
        ),
      ],
    ),
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:  MainAxisAlignment.center,
        children: <Widget>[
          InkWell(onTap: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(user: "Selamat Datang",userNum: 0,),
              ),
            );
          },
              child: Container(child: Icon(Icons.home, size: 40,))),
          Icon(Icons.wallet, size: 40,),
          Icon(Icons.person, size: 40,),
        ]

    ),
  );
  }

  Widget bottomDoctor (){
    return Container(
      height: 65,
      margin: EdgeInsets.only(
        right: 24,
        left: 24,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:  MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.wallet, size: 40,),
            Icon(Icons.wallet, size: 40,),
            Icon(Icons.person, size: 40,),
          ]

      ),
    );
  }