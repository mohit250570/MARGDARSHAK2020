import 'package:flutter/material.dart';
import 'package:margdarshak/screens/all_screen.dart';
import 'package:margdarshak/screens/favorites_places_list_screen.dart';
import 'package:margdarshak/screens/search_screen.dart';

class AppbarBottom extends PreferredSize {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => AllScreen(),
                ),
              );
            },
            child: Text("All Places"),
          ),
          Spacer(),
          OutlineButton(
            textColor: Theme.of(context).buttonColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => FavoritePlaceslistScreen(),
                ),
              );
            },
            child: Text("Favorites"),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
