import 'package:flutter/material.dart';
import 'package:serenity/widgets/auth_service.dart';
import 'package:serenity/widgets/homepage.dart';

import '../../widgets/LoginScreen.dart';

class NurseryAccount extends StatefulWidget {
  const NurseryAccount({super.key});

  @override
  State<NurseryAccount> createState() => _NurseryAccountState();
}

class _NurseryAccountState extends State<NurseryAccount> {
  var signOut = AuthService().signOut();
  String? uidUser;
  void _getUID ()async {
    setState(() {
      uidUser =  AuthService() as String?;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: Text("Account"),
        ),
        Text("${uidUser}"),
        ElevatedButton(onPressed: (){
          signOut;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }, child: Text("Logout"))
      ],
    );
  }
}
