import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:margdarshak/helpers/nearby_places.dart';
import 'package:margdarshak/helpers/place_markers.dart';
import 'package:margdarshak/models/place_model.dart';
import 'package:margdarshak/screens/map_screen.dart';
import 'package:margdarshak/screens/place_details_screen.dart';

class PlacesListScreen extends StatefulWidget {
  final String placeType;

  PlacesListScreen(this.placeType);

  @override
  _PlacesListScreenState createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  var _showMap = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("MARGDARSHAK"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: NearbyPlaces().searchNearbyPlaces(widget.placeType),
        builder: (ctx, placesSnapshot) {
          if (!placesSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Place> places = placesSnapshot.data;
          if (places.isEmpty) {
            return Center(
              child: Text("No results found!"),
            );
          }

          Set<Marker> _markers = PlaceMarkers.getMarkers(places, context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showMap = false;
                      });
                    },
                    child: Container(
                      width: size.width / 2,
                      height: 40,
                      color: _showMap ? Color(0xFF3A3D42): Color(0xFF7B808C),
                      alignment: Alignment.center,
                      child: Text(
                        "List",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showMap = true;
                      });
                    },
                    child: Container(
                      width: size.width / 2,
                      height: 40,
                      color: _showMap ?Color(0xFF7B808C) : Color(0xFF3A3D42),
                      alignment: Alignment.center,
                      child: Text(
                        "Map",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: _showMap
                    ? MapScreen(_markers)
                    : ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: Image.network(places[index].icon),
                          title: Text(places[index].name),
                          subtitle: Text(places[index].vicinity),
                          trailing: Column(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(places[index].rating == "null"
                                  ? "-"
                                  : places[index].rating),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => PlaceDetailsScreen(
                                  places[index].id,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
