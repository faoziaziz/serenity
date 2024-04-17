import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serenity/widgets/auth_service.dart';
import 'package:serenity/widgets/homepage.dart';
import 'package:serenity/tasks/AddUser.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  /* selected date controller */
  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1945),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print("${picked.toLocal()}");
        print("${selectedDate.toLocal()}");
        print("picked");
      });
    }
  }

  /* add user */
  Future<void> addUser(
      {required String fullName, required String email, required String ttl}) {
    return users
        .add({
      'full_name': fullName,
      'email': email,
      'ttl': ttl,
    })
        .then((value) => print("user Added"))
        .catchError((error) => print("Failed to add user : $error"));
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _fullnameController,
                decoration: const InputDecoration(hintText: 'Full Name'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),

            Column(
              children: <Widget>[

                const SizedBox(
                  height: 20.0,
                ),
                Text("Tanggal Lahir"),
                ElevatedButton(
                  onPressed: () => _selectedDate(context),
                  child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final message = await AuthService().registration(
                  email: _emailController.text,
                  password: _passwordController.text,
                );

                final addTodb = await addUser(
                    fullName: _fullnameController.text,
                    email: _emailController.text,
                    ttl: selectedDate.toString());
                addTodb;

                if (message!.contains('Sukses')) {
                  print(message);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}
