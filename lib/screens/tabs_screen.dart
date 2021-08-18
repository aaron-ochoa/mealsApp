import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';
import '../models/meal.dart';

//this screens goal will be to render the tabs and the content for which one is selected
class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //need to manage the list of widgets that you want to render
  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      //this is to make the title of the appBar dynamic
      {'page': CategoriesScreen(), 'title': 'Categories'},
      //cannot use widget property in to initialize these properties
      //to solve this make _pages not final and put it initalization in an init state method
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Favorites'}
    ];
    super.initState();
  }

  //gets the index automatically from flutter by which tab is choosen
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //this is to add tabs to the bottom of the appBar only really seem in some
    //Andriod apps no need for a setstate
    return /* DefaultTabController(
      length: 2,
      child: */
        Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        //sets tabs on the bottom of the appBar
/*         bottom: TabBar(
          //takes a list of widgets (tabs)
          tabs: [
            //each tab typically takes and icon
            Tab(
              icon: Icon(Icons.category),
              text: 'Categories',
            ),
            Tab(
              icon: Icon(Icons.star),
              text: 'Favorites',
            ),
          ],
        ), */
      ),
      //Creating a drawer in the appBar
      drawer: MainDrawer(),
      //takes widget children and if you select the first one it knows that
      //you selected the first tab and the second if the second is select etc..
      body:
          /* TabBarView(
        children: [CategoriesScreen(), FavoritesScreen()], */
          //output the widget by which tab was selected
          _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        //tells the navigation bar which tab is selected
        currentIndex: _selectedPageIndex,
        //if this is set then you actually need to style the items on itself
        type: BottomNavigationBarType.shifting,
        //the tabs
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
