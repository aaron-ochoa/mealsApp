import 'package:flutter/material.dart';
import 'package:mealsApp/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoriesMealsScreen extends StatefulWidget {
/*   final String categoryId;
  final String categoryTitle;

  CategoriesMealsScreen(this.categoryId, this.categoryTitle); */
  //creating a route name variable so there is no typo with connecting this to
  //correct route
  static const routeName = '/categories-meals';

  final List<Meal> availableMeals;

  CategoriesMealsScreen(this.availableMeals);

  @override
  _CategoriesMealsScreenState createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;

  @override
  //cannot use initState becuase of the ModalRoute.of(context) the .of(context) is
  //not given until the build function is called. While the initState method is ran
  //before build function is called
  //is triggered whenever the state of the function is called
  void didChangeDependencies() {
    //extracting the route argument
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    //getting the route args from dummy data
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    //only returning the recipes that are for the correct category
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      //removing the meal where the element id is equal to the mealId that we recieved
      displayedMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            //passing all of the relivent data from the widget
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            //removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
