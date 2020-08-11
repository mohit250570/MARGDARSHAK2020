import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:margdarshak/helpers/nearby_places.dart';
import 'package:margdarshak/helpers/place_markers.dart';
import 'package:margdarshak/screens/all_screen.dart';
import 'package:margdarshak/screens/map_screen.dart';
import 'package:margdarshak/screens/menu_screen.dart';
import 'package:margdarshak/widgets/tabs_screen/appbar_bottom.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _curIndex = 0;
  Set<Marker> _markers;

  Future<void> setMarkers(String placeType) async {
    if (_markers != null) {
      _markers.clear();
    }
    var places = await NearbyPlaces().searchNearbyPlaces(placeType);
    print(places);
    _markers = PlaceMarkers.getMarkers(places, context);
  }

  void setIndex(int index) {
    setState(() {
      _curIndex = index;
    });
    setMarkers(index == 0
            ? null
            : index == 1
                ? "tourist_attraction"
                : index == 2 ? "restaurant" : "hospital")
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MARGDARSHAK"),
        centerTitle: true,
      ),
      drawer: MenuScreen(),
      body: Column(
        children: <Widget>[
          AppbarBottom(),
          Divider(),
          Expanded(
            //tab body here
            child: MapScreen(_markers),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curIndex,
        onTap: setIndex,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(
          color: Colors.blueGrey,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 15,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.blueGrey,
        ),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 15,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            title: Text("All"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text("Attractions"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            title: Text("Food"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text("Hospital"),
          ),
        ],
      ),
    );
  }
}
