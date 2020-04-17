

import 'package:chatroom/ui/widget/CategorySelector.dart';
import 'package:chatroom/ui/widget/FavoriteContact.dart';
import 'package:chatroom/ui/widget/RecentChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() =>HomeScreenState ();

}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon:  Icon(Icons.menu),
          iconSize: 30,
          color:  Colors.white,
          onPressed: (){},
        ),
        title: Text(
          "Chat",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 28,
            color: Colors.white,
            onPressed: (){},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )
              ),
              child: Column(
                children: <Widget>[
                 FavoriteContact(),
                 RecentChat(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}