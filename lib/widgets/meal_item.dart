import 'package:flutter/material.dart';

import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  //final Function removeItem;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    //@required this.removeItem
  });

  //this is going to be a getter to the get the text value for the enums
  String get complexityText {
    //switch case like java
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    //switch case like java
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Expensive';
        break;
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealDetailScreen.routeName, arguments: id)
        //this is a future - it will only run when that this screen is no longer needed
        //the value that it gets is the value from the pop method from the
        //meal_detail_screen
        .then((value) {
      if (value != null) {
        //since removeItem is being passed to the screen
        //this function needs to be added to the category_meals_screen
        //removeItem(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            //adding images on top of each other in 3D space
            Stack(
              children: [
                //use this widget which uses any other widget as a child and force it into
                //a form like rounded edges
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  //getting a image from the internet
                  child: Image.network(imageUrl,
                      height: 250,
                      width: double.infinity,
                      //resizes/crops, makes the image fit into this box
                      fit: BoxFit.cover),
                ),
                //only works within a stack
                Positioned(
                  //positioning the text using bottom, right, left
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      //if the text is too long then it will wrap
                      softWrap: true,
                      //if it does not fit within the box even with the wrap it will fade
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      //just adding some space
                      SizedBox(width: 6),
                      Text('${duration} min')
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      //just adding some space
                      SizedBox(width: 6),
                      Text('${complexityText} min')
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      //just adding some space
                      SizedBox(width: 6),
                      Text('${affordabilityText} min')
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
