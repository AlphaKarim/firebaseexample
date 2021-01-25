import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseexample/chatRoomScreen.dart';
import 'package:firebaseexample/signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database.dart';
import 'helperFunctions.dart';
import 'widget.dart';
import 'package:firebaseexample/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  QuerySnapshot snapshot;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  signMeUp(){
    if(formKey.currentState.validate()){
      SharedPreferencesUtil.saveUserEmail(emailController.text);
      setState(() {
        isLoading = true;
      });
      databaseMethods.getUserByUserEmail(emailController.text)
      .then((val){
        snapshot = val;
        SharedPreferencesUtil.saveUserName(snapshot.documents[0].data()["name"]);
        print(snapshot.documents[0].data()["name"].toString());
      });

      authMethods.signInWithEmailAndPassword(emailController.text.toString(), passwordController.text.toString()).then((value) {
        print(value.user.uid.toString());
        if(value.user.uid!=null){
          print("ifCondition");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }else{
          print("elseCondition");
          setState(() {
            isLoading = false;
          });
        }
      }

      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn"),
      ),
      body:isLoading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)? null :"Provide valid email";
                        },
                        controller: emailController,
                        decoration: textInputDecoration("Email"),
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val.length>6 ? null:"Password contains more than 6 letters";
                        },
                        controller: passwordController,
                        decoration: textInputDecoration("Password"),
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
              Container(
                alignment: Alignment.centerRight,
                child:   GestureDetector(
                  onTap:() {
                    if(formKey.currentState.validate()){
                      Fluttertoast.showToast(
                          msg: "your message",
                          textColor: Colors.lightBlue,
                          backgroundColor: Colors.deepPurple,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM);
                      authMethods.resetPassword(emailController.text);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text("Forget password?",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    signMeUp();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ]
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.lightBlue,
                    ),
                    child: Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Text("Sign in with Google",style: TextStyle(color: Colors.black,fontSize: 20),),
                ),
                SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account?",style: TextStyle(color: Colors.white,fontSize: 15),),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => SignUp()));
                          },
                            child: Text("Register now",style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.underline),))
                      ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
