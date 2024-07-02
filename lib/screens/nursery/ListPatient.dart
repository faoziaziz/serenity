/*
*
*   list patient untuk menampilkan daftar pasien
* */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:serenity/providers/patientState.dart';
import 'package:provider/provider.dart';

class ListPatient extends StatefulWidget {
  const ListPatient({super.key});

  @override
  State<ListPatient> createState() => _ListPatientState();
}
/*
Future<Object?> getUsersFirebase() async {
  QuerySnapshot ds = FirebaseFirestore.instance.collection('users').where("status", isEqualTo: "user").get();
  return ds.data();
}
*/


class _ListPatientState extends State<ListPatient> {

  final Stream<QuerySnapshot> _usersStream =
  //FirebaseFirestore.instance.collection('users').snapshots();
  FirebaseFirestore.instance.collection('users').where("status", isEqualTo: "user").snapshots();

  @override
  void initState() {
    // TODO: implement initState
    // get users data


    super.initState();
  }

  /* list data */

  @override
  Widget build(BuildContext context) {
    return Consumer2<PatientState, ScreenState>(
      builder: (context, patientState, screenState, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (snapshot.hasError) {
              return Text("ada yang salah");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("lagi loding");
            }

            return SizedBox(
              height: 300,
              child: ListView(
                children:
                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
                  return InkWell(
                    onTap: (){

                      patientState.changeStateUserID(data!['email']);
                      screenState.changeStateNurse(25);

                    },
                    child: ColoredBox(
                      color: Colors.grey,
                      child: ListTile(
                        title: Text("${data!['full_name']} "),
                        subtitle: Text('${data!['email']} : ${data!['ttl']}'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        );
      }
    );
  }
}
