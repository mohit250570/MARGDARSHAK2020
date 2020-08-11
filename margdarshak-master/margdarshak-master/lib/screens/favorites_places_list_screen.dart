import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:margdarshak/providers/favorite_places.dart';
import 'package:margdarshak/helpers/nearby_places.dart';
import 'package:margdarshak/helpers/place_markers.dart';
import 'package:margdarshak/models/place_model.dart';
import 'package:margdarshak/screens/map_screen.dart';
import 'package:margdarshak/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class FavoritePlaceslistScreen extends StatefulWidget {
  @override
  _FavoritePlaceslistScreenState createState() =>
      _FavoritePlaceslistScreenState();
}

class _FavoritePlaceslistScreenState extends State<FavoritePlaceslistScreen> {
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
        future: Provider.of<FavoritePlaces>(context, listen: false)
            .setFavoritePlaces(),
        builder: (ctx, placesSnapshot) {
          if (placesSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Consumer<FavoritePlaces>(
            builder: (ctx, favPlacesProvider, _) {
              List<Place> places = favPlacesProvider.favPlaces;
              if (places.isEmpty) {
                return Center(
                  child: Text("No Favorite Places found!"),
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
                          color: _showMap ? Colors.grey[900] : Colors.grey[800],
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
                          color: _showMap ? Colors.grey[800] : Colors.grey[900],
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
          );
        },
      ),
    );
  }
}
