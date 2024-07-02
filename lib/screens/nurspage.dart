import 'dart:math';
import 'package:serenity/providers/patientState.dart';
import 'package:serenity/screens/nursery/ListPatient.dart';
import 'package:serenity/screens/nursery/NurseryAccount.dart';
import 'package:serenity/screens/nursery/PatientDetails.dart';

import 'nursery/streamNurse.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:flutter/material.dart';
import 'package:serenity/screens/nursery/NurseryScreen.dart';
import 'package:serenity/screens/navBarBot.dart';
import 'package:serenity/screens/nursery/patient.dart';
import 'dart:async';
import 'package:provider/provider.dart';



class NursPage extends StatefulWidget {
  const NursPage({this.stream, required this.choice});
  final Stream<int>? stream;
  final int? choice;

  @override
  State<NursPage> createState() => _NursPageState();
}

class _NursPageState extends State<NursPage> {
  int? choicespage=0;

  void setPageNurs(int choices){
    setState(() {
      choicespage= choices;

    });

  }

  @override
  void initState() {
    choicespage = widget.choice;
    print("Init CHoice ${choicespage}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenState>(
      builder: (context, screenState, child) {
        return Stack(
          children: [
            Column(children: <Widget>[
              whichNurseryScreen(screenState.stateNurse),
            ]),
          ],
        );
      }
    );
  }

  Widget whichNurseryScreen(int? pilihan) {

    switch (pilihan) {
      case 0:
        return NurseryScreen(callbackFunction: setPageNurs,);
      case 1:
        return ListPatient();
      case 2:
        return NurseryAccount();
      case 3:
        return UserNurseryScreen(cbFunc: setPageNurs,);
      case 25: //details patient
        return Consumer<PatientState>(
          builder: (context, patientState, child) {
            return PatientDetails(userid: patientState.stateUserID);
          }
        );
      default:
        return NurseryScreen(callbackFunction: setPageNurs,);
    }
  }
}

