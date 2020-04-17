import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategorySelectorState();

}

class CategorySelectorState extends State <CategorySelector> {
  int selectedIndex = 0;
  final List <String> categories = ["Message", " Online", "Group", "Request"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 90.0,
      color: Colors.blue,
      child: ListView.builder(

          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                setState(() {
                  selectedIndex =index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20
                ),
                child: Text(categories[index], style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: (index==selectedIndex)? Colors.white : Colors.white60,
                  letterSpacing: 1.2
                )
                  ,),
              ),
            );
          }
      ),
    );
  }
}