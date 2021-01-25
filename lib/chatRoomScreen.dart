import 'dart:ui';

import 'package:firebaseexample/constants.dart';
import 'package:firebaseexample/helperFunctions.dart';
import 'package:firebaseexample/searchScreen.dart';
import 'package:firebaseexample/signin.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }
  getUserInfo() async {
    Constants.myName = await SharedPreferencesUtil.getUserName();
    SharedPreferencesUtil.saveUserLoginBool(true);
  }

  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Head"),
        actions: [
          GestureDetector(
            onTap: (){
              SharedPreferencesUtil.saveUserLoginBool(false);
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Icon(Icons.exit_to_app)
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
      body: Container(
        child: Center(
          child: Container(
            child: Text("This is chat room",style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.underline),),
          ),
        ),
      ),
    );
  }
}
