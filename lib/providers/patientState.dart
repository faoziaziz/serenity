import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientState with ChangeNotifier {
  String _userID="azizfaozi@tampant.tech";
  String get stateUserID => _userID;

  void changeStateUserID(String UserID){
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