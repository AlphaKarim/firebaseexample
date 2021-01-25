import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseexample/conversationScreen.dart';
import 'package:firebaseexample/database.dart';
import 'package:firebaseexample/helperFunctions.dart';
import 'package:firebaseexample/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  QuerySnapshot snapshot;
  TextEditingController searchController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Widget searchList(){
    return snapshot != null? ListView.builder(
        itemCount: snapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context,index) {
          return SearchFile(
            userName :snapshot.documents[index].data()["name"].toString(),
            userEmail :snapshot.documents[index].data()["email"].toString(),
          );
        }) : Container();
  }

  initiateSearch(){
    databaseMethods.getUserByUserName(searchController.text).then((val){
      setState(() {
        snapshot = val;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // initiateSearch();
  }
 Widget SearchFile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName,
                style: TextStyle(color: Colors.white,fontSize: 20),),
              SizedBox(height: 6,),
              Text(userEmail,
                style: TextStyle(color: Colors.white,fontSize: 20),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConvo(userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(18)
              ),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 14),
              child: Text("Message"),
            ),
          )
        ],
      ),
    );
 }

  createChatRoomAndStartConvo(String userNameOfSearch){
    String ownUserName = "";
    setState(() {
      ownUserName = SharedPreferencesUtil.getUserName().toString();
      print(ownUserName);
    });
    if(userNameOfSearch != ownUserName){
      String chatRoomId = getChatRoomId(userNameOfSearch.toString(),
          ownUserName);
      List<String> users = [
        userNameOfSearch,
        ownUserName
      ];
      Map<String,dynamic> chatRoomMap = {
        "users":users,
        "chatroomId": chatRoomId
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ConversationScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Container(
        child: Column(children: [
          Container(
            color: Color(0x54FFFFFF),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
            child: Row(
              children: [
                Expanded(child: TextField(
                  controller: searchController,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white54
                      ),
                      hintText: "Search user name...."
                  ),
                )),
                SizedBox(width: 30,),
                GestureDetector(
                  onTap: (){
                    initiateSearch();
                    },
                  child: Container(
                    width: 40,
                      height: 40,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0x36FFFFFF),
                            const Color(0x0FFFFFFF)
                          ],
                        )
                      ),
                      child: Image.asset("assets/images/search.png",)),
                )
              ],
            ),
          ),
          searchList(),
        ],),
      ),
    );
  }
}




getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a".toString();
  } else {
    return "$a\_$b".toString();
  }
}

