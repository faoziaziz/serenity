import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/patientState.dart';
import 'package:serenity/providers/screenstate.dart';


class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientState>(
      builder: (context, patState, child) {
        return Container(
          
          child: Column(
            children: [
              const Text("Patient Home"),
              Text("${patState.stateUserOwner}"),
            ],
          ),
        );
      }
    );
  }

}
