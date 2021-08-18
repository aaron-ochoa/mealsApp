import 'package:flutter/material.dart';

import '../screens/categories_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  //configuring the selectCategory to transition the screen when a category item
  //is selected
  void selectCategory(BuildContext ctx) {
    //Mobile apps are like a stack so they need to be pushed and popped to see new screens
    //pushNamed takes the named route plus argements
    //in this case we want to pass a map for the id and title of the screen
    Navigator.of(ctx).pushNamed(CategoriesMealsScreen.routeName,
        arguments: {'id': id, 'title': title});

    //Also is a Cupertino page route that works the same
    /* MaterialPageRoute(
        //needs the context
        builder: (_) {
          //forwarding the id and title information
          return CategoriesMealsScreen(id, title);
        },
      ), */
  }

  @override
  Widget build(BuildContext context) {
    //type of button that fires off a ripple affect when the user taps the button
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        //optimize the build process by adding const to the margins
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        //gradient so the background will transition between two colors
        //first colors is the color is starts with and the second color is the color
        //it will end up as
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              //setting the gradient to start in the topLeft and end in the bottomRight
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
