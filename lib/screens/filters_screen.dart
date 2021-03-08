import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters["gluten"];
    _lactoseFree = widget.currentFilters["lactose"];
    _vegan = widget.currentFilters["vegan"];
    _vegetarian = widget.currentFilters["vegetarian"];

    super.initState();
  }

  Widget buildSwitchList(bool chosenValue, String title, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: chosenValue,
      subtitle: Text("only include ${title} meals"),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("filters"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  "gluten": _glutenFree,
                  "lactose": _lactoseFree,
                  "vegan": _vegan,
                  "vegetarian": _vegetarian
                };
                widget.saveFilters(selectedFilters);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchList(_glutenFree, "Gluteen-Free", (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              buildSwitchList(_vegan, "Vegan", (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              buildSwitchList(_vegetarian, "Vegeratian", (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              buildSwitchList(_lactoseFree, "Lactos-Free", (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              })
            ],
          )),
        ],
      ),
    );
  }
}
