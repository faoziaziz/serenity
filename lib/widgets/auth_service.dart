import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Sukses';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Password terlalu lelmah';
      } else if (e.code == 'email-already-in-use') {
        return 'Akun sudah tersedia untuk email ini';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,);
      return 'Sukses';
    } on FirebaseAuthException catch (e){
      if(e.code=='user-not-found'){
        return 'No user found for that email.';
      } else if(e.code == 'wrong-password'){
        return 'Password Salah';
      } else {
        return e.message;
      }
    }catch(e){
      return e.toString();
    }
  }

  Future<bool?> isUserLogged() async {
    if (await FirebaseAuth.instance.currentUser == null){
      return false;
    } else {
      return true;
    }
  }

  Future<String?> getUser() async {
    try {
      String? userString = await FirebaseAuth.instance.currentUser!.uid;
      print (userString);
      return userString;
    } catch(e){
      return e.toString();
    };
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }


}
