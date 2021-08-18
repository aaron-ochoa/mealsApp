import "package:flutter/material.dart";

import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Every screen should return a scaffold widget to have the appBar and overall
    //look of th screen
    //only time that you dont return a Scaffold is if you have a tabs on the bottom
    //of the AppBar then you just return the body so that there are not 2 appBars
    return /* Scaffold(
      appBar: AppBar(
        title: const Text('Deli Meals'),
      ),
      //creates a list with some items side-by-side
      //needs to pass the gridDelegate parameter
      body: */
        GridView(
      padding: const EdgeInsets.all(25),
      children:
          //creating a list of widgets from the dummy data and returning a list of
          //CategoryItem widgets
          DUMMY_CATEGORIES
              .map((e) => CategoryItem(e.id, e.title, e.color))
              .toList(),
      //helps setup the grid
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //how many pixels each column should get
          maxCrossAxisExtent: 200,
          //height and width relation of the tiles
          childAspectRatio: 3 / 2,
          //spacing
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
    );
  }
}
