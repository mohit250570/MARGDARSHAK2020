import 'package:flutter/material.dart';
import 'package:margdarshak/screens/about_us_screen.dart';
import 'package:margdarshak/screens/search_screen.dart';
import 'package:margdarshak/widgets/all_screen/all_screen_grid_item.dart';
import '../data/place_types.dart';

class AllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Place> _places = PlaceTypes().placesList;

    void pushScreen(Widget screen) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => screen,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("MARGDARSHAK"),
        centerTitle: true,
        actions: <Widget>[
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
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              print(value);
              if (value == 1) {
                pushScreen(AboutUsScreen());
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text("Check for update"),
                value: 0,
              ),
              PopupMenuItem(
                child: Text("About Margdarshak"),
                value: 1,
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.5 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: _places.length,
          itemBuilder: (ctx, index) => AllScreenGridItem(place: _places[index]),
        ),
      ),
    );
  }
}
