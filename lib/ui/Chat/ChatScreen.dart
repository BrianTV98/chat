import 'package:chatroom/model/MessageModel.dart';
import 'package:chatroom/model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen(this.user);

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              // padding: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                  reverse: true,
                  itemCount: message.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message mes = message[index];
                    final bool isMe = mes.sender.id == currentUser.id;
                    return _buidMessage(mes, isMe);
                  }),
            ),
          ),
          _buidMessageComposer()
        ],
      ),
    );
  }

  Widget _buidMessage(Message message, bool isMe) {
    final Container msg = Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(message.time),
              SizedBox(
                height: 5,
              ),
              Text(
                message.text,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: Color(0xFFCCF0D0),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
        ));
    if (isMe) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(left: 80),
            child: msg,
          ),
        ],
      );
    }
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: <Widget>[
                msg,
                IconButton(
                  icon: (message.isLiked)
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  color: (message.isLiked) ? Colors.red : Colors.blueGrey,
                  onPressed: () => setState(() {
                    message.isLiked = !message.isLiked;
                  }),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buidMessageComposer() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.image),
            color: Theme.of(context).primaryColor,
            iconSize: 30,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Send a messager ...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.blue,
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
