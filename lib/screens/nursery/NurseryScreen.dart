import 'streamNurse.dart';
import 'package:flutter/material.dart';
import 'package:serenity/screens/nursery/patient.dart';
import 'package:serenity/widgets/CounterProvider.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:serenity/providers/userState.dart';



class NurseryScreen extends StatefulWidget {
  final Function callbackFunction;

  const NurseryScreen({super.key, required this.callbackFunction});

  @override
  State<NurseryScreen> createState() => _NurseryScreenState();
}

class _NurseryScreenState extends State<NurseryScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ScreenState, UserState>(
        builder: (context, screenState, userState, child) {
        return Column(
          children: [
            Container(
              child: Text(userState.stateUserOwner),
            ),
            Text(
              "List Pasien",
              textAlign: TextAlign.center,
            ),


            Text('${screenState.stateNurse}', style: TextStyle(fontSize: 30),),
          ],
        );
      }
    );;
  }
}
