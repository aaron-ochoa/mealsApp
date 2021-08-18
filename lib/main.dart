import 'package:flutter/material.dart';

import './dummy_data.dart';
import 'screens/categories_meals_screen.dart';
import 'screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //setting a map to save the filters that the user has sets
  Map<String, bool> _filters = {
    //setting the default filters
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  //usually to get the list of meals the we are getting that directly from the
  //DUMMY_DATA but since we want to start using the filters this needs to change
  //so we will manage the list of available meals in the main.dart file now

  List<Meal> _availabledMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  //usually you would want to make a modal instead of using Map<String, bool>
  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      //will go through the list of avaliabeMeals and replace them
      //then turn then back into a list
      _availabledMeals = DUMMY_MEALS.where((meal) {
        //check all filters with if statements -- wont include if false
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  //this will be a toggle method to either add or more the meal from the list
  //of favorites
  void _toggleFavorite(String mealId) {
    final existingIndex =
        //checks if the element is part of that list then automatically give
        //the index of where that element is if it is not part then it will return -1
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    /* ^since this will be a toggle method, if this is true then we know we have to
        remove it, and if it returns a -1 that means the meal is not in the list
        and we know we need to add it */
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    //adding the meal from the DUMMY_MEAL data
    else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  //returns a boolean to check to see if the meal is already a favorite
  bool _isMealFavorite(String id) {
    //if any returns true then it will continue
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      //setting up theme data
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ))),
      //home points to which screen will be the starting point for your app
      //home automatically has a named route of '/'

      //you can forward the favorites to the tabsScreen then in the tabs screen
      //forward it to the favoritesScreen
      home: TabsScreen(_favoriteMeals),
      //setting the routes table with the route arguement
      //routes table will make it easier setting up more routes then setting them
      //all in each individual screen.
      routes: {
        //instead of type the which there could be a typo create a static value and
        //refer to it here
        CategoriesMealsScreen.routeName: (ctx) =>
            CategoriesMealsScreen(_availabledMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        //able to pass data through routes
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilter),
      },
      //That's correct. onGenerateRoute is your fallback/ option to have more
      //control about the creation + configuration of routing actions
      // (= MaterialPageRoute that then loads a specific screen widget).
      //fail safe if route fails this will be a failback - including this is a good idea
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
