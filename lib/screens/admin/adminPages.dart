import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/screenstate.dart';
class AdminPages extends StatefulWidget {
  const AdminPages({super.key});

  @override
  State<AdminPages> createState() => _AdminPagesState();
}

class _AdminPagesState extends State<AdminPages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenState>(
      builder: (context, screenState, child) {
        return Column(
          children: [
            Text("Admin Pages, untuk halaman admin"),
            ElevatedButton(onPressed: (){
              screenState.changeStateAdmin(1);
            }, child: Text("List Dokter")),
            Text("Admin Pages, untuk halaman admin"),
            ElevatedButton(onPressed: (){
              screenState.changeStateAdmin(2);
            }, child: Text("List Nurse")),
            Text("Admin Pages, untuk halaman admin"),
            ElevatedButton(onPressed: (){
              screenState.changeStateAdmin(3);
            }, child: Text("List Patient")),
            Text("Admin Pages, untuk halaman admin"),
            ElevatedButton(onPressed: (){
              screenState.changeStateAdmin(4);
            }, child: Text("List User")),
            Text("Admin Pages, untuk halaman admin"),
            ElevatedButton(onPressed: (){
              screenState.changeStateAdmin(0);
            }, child: Text("Admin Home")),
          ],
        );
      }
    );
  }
}
