import 'package:firebaseexample/auth.dart';
import 'package:firebaseexample/chatRoomScreen.dart';
import 'package:firebaseexample/database.dart';
import 'package:firebaseexample/helperFunctions.dart';
import 'package:firebaseexample/signin.dart';
import 'package:flutter/material.dart';
import 'widget.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signMeUp(){
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      authMethods.signUpWithEmailAndPassword(emailController.text.toString(), passwordController.text.toString()).then((value) {
        // print(value.toString());
        Map<String,String> map = {
          "name":userNameController.text,
          "email":emailController.text
        };
        SharedPreferencesUtil.saveUserEmail(emailController.text);
        SharedPreferencesUtil.saveUserName(userNameController.text);
        databaseMethods.uploadUsersList(map);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoom()));
      }

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
      ),
      body: isLoading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -50,
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
                          return val.isEmpty || val.length<4 ?"Provide valid UserName":null;
                        },
                        controller: userNameController,
                        decoration: textInputDecoration("Username"),
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
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
                SizedBox(height: 40,),
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
                    Text("already have an account?",style: TextStyle(color: Colors.white,fontSize: 15),),
                    SizedBox(width: 10,),
                    GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => SignIn()));
                        },
                        child: Text("SignIn here",style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.underline),))
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
