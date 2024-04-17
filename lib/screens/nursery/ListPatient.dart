/*
*
*   list patient untuk menampilkan daftar pasien
* */

import 'package:flutter/material.dart';

class ListPatient extends StatefulWidget {
  const ListPatient({super.key});

  @override
  State<ListPatient> createState() => _ListPatientState();
}

class _ListPatientState extends State<ListPatient> {

  /* list data */

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Scrollbar(
        child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  Text("Pasien "),
                  Text("Nomer ${index}"),
                ],
              );
            }),
      ),
    );
  }
}
