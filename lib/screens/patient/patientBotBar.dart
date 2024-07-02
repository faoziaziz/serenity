import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/patientState.dart';
import 'package:serenity/providers/screenstate.dart';

class PatientBotBar extends StatefulWidget {
  const PatientBotBar({super.key});

  @override
  State<PatientBotBar> createState() => _PatientBotBarState();


}

class _PatientBotBarState extends State<PatientBotBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PatientState, ScreenState>(
      builder: (context, patState, screenState, child) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      screenState.changeStatePatient(0);
                    },
                    child: Container(
                        child: Icon(
                          Icons.home,
                          size: 40,
                        ))),

                InkWell(
                    onTap: () {
                      screenState.changeStatePatient(1);
                    },
                    child: Container(
                        child: Icon(
                          Icons.music_note,
                          size: 40,
                        ))),

                InkWell(
                    onTap: () {
                      screenState.changeStatePatient(2);
                    },
                    child: Container(
                        child: Icon(
                          Icons.auto_stories_outlined,
                          size: 40,
                        ))),

              ]),
        );
      }
    );;
  }
}
