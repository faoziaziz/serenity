import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serenity/tasks/AddUser.dart';
import 'package:serenity/widgets/auth_service.dart';
import 'package:serenity/widgets/homepage.dart';
import '../../widgets/LoginScreen.dart';
import '../../widgets/auth_service.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  Future<String?> _getUserID ()async{
    return await AuthService().getUser();
  }
  User currentUser = FirebaseAuth.instance.currentUser!;

  String? curUser;
  /*
  *   Collection Reference untuk
  * */
  @override
  void initState(){
    _getUserID();
    // TODO: implement initState
    curUser=currentUser.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var signOut = AuthService().signOut();
    return Consumer<ScreenState>(builder: (context, screenState, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("ada yang salah");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("lagi loding");
            }

            return SizedBox(
              height: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text("User"),
                  ElevatedButton(
                      onPressed: () {
                        screenState.changeStateAdmin(1);
                      },
                      child: Text("List Dokter")),
                  Text("Admin Pages, untuk halaman admin"),

                  ElevatedButton(
                      onPressed: () {
                        screenState.changeStateAdmin(0);
                      },
                      child: Text("ds")),

                  Text("cur user : ${curUser}"),

                  ElevatedButton(onPressed: (){
                    //signOut;

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );


                  }, child: Text("Logout")),
                  SizedBox(
                    height: 150,

                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ListTile(
                          title: Text("$data['full_name'] "),
                          subtitle: Text('${data['email']} : ${data['ttl']}'),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}

class GetUsername extends StatelessWidget {
  final String documentId;
  const GetUsername({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
