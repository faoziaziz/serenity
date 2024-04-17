import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ScreenState with ChangeNotifier {
  int _stateNurse = 0;
  int get stateNurse => _stateNurse;


  int _stateAdmin=0;
  int get stateAdmin=> _stateAdmin;
  /*
  *   1. HomePage page
  *   2. List Patient page
  *   3. Scheduling page
  *   4. Content Creator page
  * */
  int _stateBot=0;
  int get stateBot => _stateBot;


  void changeStateNurse(int choices) {
    _stateNurse=choices;
    notifyListeners();
  }

  void changeStateBot(int choices){
    _stateBot= choices;
    notifyListeners();
  }

  void changeStateAdmin(int choices){
    _stateAdmin = choices;
    notifyListeners();
  }
}