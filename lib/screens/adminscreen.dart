import 'package:flutter/material.dart';
import 'package:serenity/screens/admin/adminPages.dart';
import 'package:provider/provider.dart';
import 'package:serenity/providers/screenstate.dart';
import 'package:serenity/screens/admin/listDoctors.dart';
import 'package:serenity/screens/admin/listNurse.dart';
import 'package:serenity/screens/admin/listPatient.dart';
import 'package:serenity/screens/admin/listUser.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenState>(
      builder: (context, screenState, child) {
        return Container(
          child: whichAdminScreen(screenState.stateAdmin),
        );
      }
    );;
  }

  /* Screen yang mana yah ? */
  Widget whichAdminScreen(int choices){
    switch(choices){
      case 0 : return AdminPages();
      case 1 : return ListDoctor();
      case 2 : return ListPatient();
      case 3 : return ListNurse();//ListUser();
      case 4 : return ListUser();
      default : return AdminPages();
    }
  }
}


