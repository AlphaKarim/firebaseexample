import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseexample/helperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:firebaseexample/chatRoomScreen.dart';
import 'signup.dart';
import 'signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RunMyApp());
}

class RunMyApp extends StatefulWidget {
  @override
  _RunMyAppState createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  bool logInState = false;
  @override
  void initState() {
    super.initState();
    getSavedBoolValue();
  }
  getSavedBoolValue() async {
    if(SharedPreferencesUtil.getUserLoginBool() != null){
      logInState =await SharedPreferencesUtil.getUserLoginBool();
    } else{
      logInState = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: !logInState?SignIn():ChatRoom(),
      debugShowCheckedModeBanner: false,
    );
  }
}


