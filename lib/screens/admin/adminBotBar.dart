import 'package:flutter/material.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:provider/provider.dart';


class AdminBotBar extends StatefulWidget {
  const AdminBotBar({super.key});

  @override
  State<AdminBotBar> createState() => _AdminBotBarState();
}

class _AdminBotBarState extends State<AdminBotBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenState>(
      builder: (context, screenState, child) {
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
                      screenState.changeStateAdmin(0);
                    },
                    child: Container(
                        child: Icon(
                          Icons.home,
                          size: 40,
                        ))),
                InkWell(
                    onTap: () {
                      screenState.changeStateAdmin(1);
                    },
                    child: Container(
                        child: Icon(
                          Icons.apple,
                          size: 40,
                        ))),
                InkWell(
                    onTap: () {
                      print("anjing 2");

                      screenState.changeStateAdmin(2);
                    },
                    child: Container(
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ))),
                InkWell(
                    onTap: () {
                      screenState.changeStateAdmin(3);

                    },
                    child: Container(
                        child: Icon(
                          Icons.people,
                          size: 40,
                        ))),
              ]),
        );
      }
    );
  }
}
