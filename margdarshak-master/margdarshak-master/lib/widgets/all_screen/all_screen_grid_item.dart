import 'package:flutter/material.dart';
import 'package:margdarshak/data/place_types.dart';
import 'package:margdarshak/screens/places_list_screen.dart';

class AllScreenGridItem extends StatelessWidget {
  final Place place;

  AllScreenGridItem({
    @required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => PlacesListScreen(place.type),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5),
        child: LayoutBuilder(
          builder: (ctx, constraints) => Column(
            children: <Widget>[
              Container(
                width: 100,
                height: constraints.maxHeight * 0.7,
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset(
                  place.assetImagePath,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                place.name,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
