import 'package:flutter/material.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:serenity/widgets/homepage.dart';
import 'package:serenity/widgets/CounterProvider.dart';
import 'package:provider/provider.dart';

class NurseryBotBarSTFULL extends StatefulWidget {
  final Function callBackFunction;
  const NurseryBotBarSTFULL({super.key, required this.callBackFunction});

  @override
  State<NurseryBotBarSTFULL> createState() => _NurseryBotBarSTFULLState();
}

class _NurseryBotBarSTFULLState extends State<NurseryBotBarSTFULL> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CounterProvider, ScreenState>(
      builder: (context, counterProvider, screenState, child) {
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
                      print("anjing 0");
                      widget.callBackFunction(0);
                      screenState.changeStateNurse(0);
                    },
                    child: Container(
                        child: Icon(
                      Icons.home,
                      size: 40,
                    ))),
                InkWell(
                    onTap: () {
                      print("anjing 1");
                      widget.callBackFunction(1);
                      screenState.changeStateNurse(1);
                    },
                    child: Container(
                        child: Icon(
                      Icons.wallet,
                      size: 40,
                    ))),
                InkWell(
                    onTap: () {
                      print("anjing 2");
                      widget.callBackFunction(2);
                      screenState.changeStateNurse(2);
                    },
                    child: Container(
                        child: Icon(
                      Icons.person,
                      size: 40,
                    ))),
                InkWell(
                    onTap: () {
                      print("anjing 3");
                      widget.callBackFunction(3);
                      screenState.changeStateNurse(3);
                      counterProvider.increment();
                    },
                    child: Container(
                        child: Icon(
                      Icons.people,
                      size: 40,
                    ))),
              ]),
        );
      },
    );
  }
}
