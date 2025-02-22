import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serenity/providers/patientState.dart';
import 'package:serenity/providers/userState.dart';
import 'package:serenity/widgets/LoginScreen.dart';
import 'package:serenity/widgets/auth_service.dart';
import 'package:serenity/widgets/homepage.dart';
import 'package:serenity/widgets/login.dart';
import 'package:serenity/widgets/authgate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:serenity/widgets/CounterProvider.dart';
import 'package:serenity/providers/screenstate.dart';


StreamController<int> streamController = StreamController<int>();



Future<void> main() async {

  /* main asyncronus */
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CounterProvider()),
    ChangeNotifierProvider(create: (_) => ScreenState()),
    ChangeNotifierProvider(create: (_) => PatientState()),
    ChangeNotifierProvider(create: (_) => UserState()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serenity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<UserState>(
        builder: (context, userState, child) {
          return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User? user = snapshot.data;
                  if(snapshot.hasError){
                    return Text("lagi error");
                  }
                  if (user == null) {
                    print("akun tak terdeteksi");
                    return LoginScreen();
                  } else if (snapshot.hasData) {


                    //userState.changeStateUserOwner(snapshot.data!.email.toString());
                    return  HomePage();
                  }
                  return const CircularProgressIndicator();
                    //Text("homepage ${user.toString()}");
                    //HomePage(user: user.toString(), userNum: 1,);
                 // return Text("homepage");
                 }
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              });
        }
      ),
    );
  }
}
