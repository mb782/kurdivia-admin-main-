import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kurdivia_admin/constants.dart';
import 'package:kurdivia_admin/provider/ApiService.dart';
import 'package:kurdivia_admin/screen/login.dart';
import 'package:kurdivia_admin/screen/menu.dart';
import 'package:provider/provider.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiService(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen()
        //
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loggedIn = false;


  @override
  void initState() {
    if (auth.currentUser != null) {
      loggedIn = true;
    } else {
      loggedIn = false;
    }
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => (loggedIn) ? Menu() : Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kDarkBlue,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/1.jpg'),fit: BoxFit.cover)
          ),
          child: Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: const Text(
                  'Admin App',
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ),
        ));
  }
}