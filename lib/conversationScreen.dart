import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {


  Widget ChatMessageList(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Screen"),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                child: Row(
                  children: [
                    Expanded(child: TextField(
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
                          hintText: "Send Message..."
                      ),
                    )),
                    SizedBox(width: 30,),
                    GestureDetector(
                      onTap: (){

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
                          child: Image.asset("assets/images/send.png",)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
