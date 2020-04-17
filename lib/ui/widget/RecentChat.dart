import 'package:chatroom/model/MessageModel.dart';
import 'package:chatroom/ui/Chat/ChatScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentChat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecentChatState();
}

class RecentChatState extends State<RecentChat> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
        ),
        child: ListView.builder(
          itemCount: chat.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> ChatScreen(chat[index].sender))),
              child: Container(
                decoration: BoxDecoration(
                    color: chat[index].unread ? Colors.white : Color(0xFFFFFEFFE),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                AssetImage(chat[index].sender.imageUrl),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  chat[index].sender.name,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(chat[index].text)
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(chat[index].time),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              color:chat[index].unread? Colors.white: Colors.red,
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child:  Text(chat[index].unread ? "" : "New",),
                            )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
