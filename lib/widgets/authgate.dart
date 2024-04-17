import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/widgets/homepage.dart';
import 'package:serenity/widgets/CustomSignInScreen.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // ...
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // User is not signed in
            if (!snapshot.hasData) {
              CustomSignInScreen();
            }

            // Render your application if authenticated
            return HomePage();
          },
        );
      },
    );
  }
}