import 'package:chatroom/model/MessageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoriteContactState();
}

class FavoriteContactState extends State<FavoriteContact> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Favorite contact",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.more_horiz),
                iconSize: 30,
                color: Colors.blueGrey,
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(favorites[index].imageUrl),
                      ),
                      Text(favorites[index].name),
                    ],
                  ),
                );
              },
            ))
      ],
    );
  }
}
