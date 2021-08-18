import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  //these will be the properties for the switches of filters
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  //setting the initState so when this page comes up these values will become initialzed
  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  //builder function for the list of switches
  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [
            //reach out to the widget to call .saveFilters
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  {
                    //using the map and call what the user chose
                    final selectFilters = {
                      //setting the default filters
                      'gluten': _glutenFree,
                      'lactose': _lactoseFree,
                      'vegan': _vegan,
                      'vegetarian': _vegetarian
                    };
                    widget.saveFilters(selectFilters);
                  }
                }),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            //will take all of the remaining space to the end of the screen
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                      'Gluten-Free',
                      'Only include gluten-free meals',
                      _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Lactose-free',
                      'Only include Lactose-free meals',
                      _lactoseFree, (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }),
                  _buildSwitchListTile('Vegetarian',
                      'Only include vegetarian meals', _vegetarian, (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegan', 'Only include vegan meals', _vegan, (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  })
                ],
              ),
            )
          ],
        ));
  }
}
