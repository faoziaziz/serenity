import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  const AddUser({
    super.key,
    required this.fullName,
    required this.company,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      return users
          .add({
            'full_name': fullName,
            'company': company,
            'age': age,
          })
          .then((value) => print("user Added"))
          .catchError((error) => print("Failed to add user : $error"));
    }

    return ElevatedButton(
      onPressed: addUser,
      child: Text("add users"),
    );
  }
}
