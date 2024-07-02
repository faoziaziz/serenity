import 'package:flutter/material.dart';
import 'package:serenity/screens/patient/PatientAccount.dart';
import 'package:serenity/screens/patient/PatientHealth.dart';
import 'package:serenity/screens/patient/patientHome.dart';
import 'package:serenity/providers/patientState.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:serenity/screens/patient/patientSchedule.dart';
import 'package:provider/provider.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenState>(
      builder: (context, screenState, child) {
        return Container(
          child: whichPatientScreen(screenState.statePatient),
        );
      }
    );
  }

  Widget whichPatientScreen(int number){
    switch (number){
      case 0 : return PatientHome();
      case 1 : return PatientSchedule();
      case 2 : return PatientHealth();
      case 3 : return PatientAccount();
      default : return PatientHome();
    }

    return SizedBox(height: 10,);
  }
}
