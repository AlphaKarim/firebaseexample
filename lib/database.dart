import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUserName(String username) async{
    return await Firestore.instance.collection("users").where("name",isEqualTo: username).getDocuments();
  }
  getUserByUserEmail(String email) async{
    return await Firestore.instance.collection("users").where("email",isEqualTo: email).getDocuments();
  }

  uploadUsersList(userMap){
    Firestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatRoomId,chatRoomMap){
    Firestore.instance.collection("CharRoom").document(chatRoomId)
    .setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
}