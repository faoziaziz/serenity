import 'streamNurse.dart';
import 'package:flutter/material.dart';
import 'package:serenity/screens/nursery/patient.dart';
import 'package:serenity/widgets/CounterProvider.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/screenstate.dart';

class NurseryScreen extends StatefulWidget {
  final Function callbackFunction;

  const NurseryScreen({super.key, required this.callbackFunction});

  @override
  State<NurseryScreen> createState() => _NurseryScreenState();
}

class _NurseryScreenState extends State<NurseryScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<CounterProvider, ScreenState>(
      builder: (context, counterProvider, screenState, child) {
        return Column(
          children: [
            Container(
              child: Text("Nursery Pages"),
            ),
            Text(
              "List Pasien",
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        size: 60,
                        color: Colors.red,
                      ),
                      Text("Aziz Faozi"),
                    ],
                  ),
                  onTap: () {
                    widget.callbackFunction(1);
                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        size: 60,
                        color: Colors.red,
                      ),
                      Text("Aziz Faozi"),
                    ],
                  ),
                  onTap: () {
                    print("Aziz Faozi di Click");
                    screenState.changeStateNurse(2);

                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        size: 60,
                        color: Colors.red,
                      ),
                      Text("Aziz Faozi"),
                    ],
                  ),
                  onTap: () {
                    print("Aziz Faozi di Click");
                    screenState.changeStateNurse(3);
                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        size: 60,
                        color: Colors.red,
                      ),
                      Text("Aziz Faozi"),
                    ],
                  ),
                  onTap: () {
                    print("Aziz Faozi di Click");
                    screenState.changeStateNurse(4);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        size: 60,
                        color: Colors.red,
                      ),
                      Text("Aziz Faozi"),
                    ],
                  ),
                  onTap: () {
                    print("Aziz Faozi di Click");
                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        size: 60,
                        color: Colors.red,
                      ),
                      Text("Aziz Faozi"),
                    ],
                  ),
                  onTap: () {
                    print("Aziz Faozi di Click");
                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        size: 60,
                        color: Colors.red,
                      ),
                      Text("Aziz Faozi"),
                    ],
                  ),
                  onTap: () {
                    print("Aziz Faozi di Click");
                  },
                ),
                InkWell(
                  child: Column(
                    children: [
                      Icon(
                        Icons.people,
                        size: 60,
                        color: Colors.red,
                      ),
                      Text("Aziz Faozi"),
                    ],
                  ),
                  onTap: () {
                    print("Aziz Faozi di Click");
                  },
                ),
              ],
            ),
            Text('${counterProvider.count}', style: TextStyle(fontSize: 30),),
            Text('${screenState.stateNurse}', style: TextStyle(fontSize: 30),),
          ],
        );
      }
    );;
  }
}
