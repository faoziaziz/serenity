import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  String _userID="azizfaozi@tampant.tech";
  String get stateUserID => _userID;

  void change(String UserID){
    _userID = UserID;
    notifyListeners();
  }

  String _userOwner = "azizfaozi@tampan.tech";
  String get stateUserOwner => _userOwner;

  void changeStateUserOwner(String UserOwner){
    _userOwner=UserOwner;
    notifyListeners();
  }

}