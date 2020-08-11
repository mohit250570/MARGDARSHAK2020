class Place {
  String assetImagePath;
  String name;
  String type;

  Place({this.assetImagePath, this.name, this.type});
}

class PlaceTypes {
  List<Place> _placesList = [
    Place(
      assetImagePath: "assets/images/hospital.jpg",
      name: "Hospital",
      type: "hospital",
    ),
    Place(
      assetImagePath: "assets/images/airport.png",
      name: "Airport",
      type: "airport",
    ),
    Place(
      assetImagePath: "assets/images/restaurant.png",
      name: "Restaurant",
      type: "restaurant",
    ),
    Place(
      assetImagePath: "assets/images/atm.png",
      name: "ATM",
      type: "atm",
    ),
    Place(
      assetImagePath: "assets/images/bank.png",
      name: "Bank",
      type: "bank",
    ),
    Place(
      assetImagePath: "assets/images/beauty_salon.png",
      name: "Beauty Salon",
      type: "beauty_salon",
    ),
    Place(
      assetImagePath: "assets/images/cafe.png",
      name: "Cafe",
      type: "cafe",
    ),
    Place(
      assetImagePath: "assets/images/car_rental.webp",
      name: "Car rental",
      type: "car_rental",
    ),
    Place(
      assetImagePath: "assets/images/dentist.png",
      name: "Dentist",
      type: "dentist",
    ),
    Place(
      assetImagePath: "assets/images/departmental_store.png",
      name: "Departmental Store",
      type: "department_store",
    ),
    Place(
      assetImagePath: "assets/images/doctor.png",
      name: "Doctor",
      type: "doctor",
    ),
    Place(
      assetImagePath: "assets/images/electrician.png",
      name: "Electrician",
      type: "electrician",
    ),
    Place(
      assetImagePath: "assets/images/gym.png",
      name: "Gym",
      type: "gym",
    ),
    Place(
      assetImagePath: "assets/images/hardware_store.png",
      name: "Hardware Store",
      type: "hardware_store",
    ),
    Place(
      assetImagePath: "assets/images/jewellery_store.png",
      name: "Jewellery Store",
      type: "jewelry_store",
    ),
    Place(
      assetImagePath: "assets/images/laundry.png",
      name: "Laundry",
      type: "laundry",
    ),
    Place(
      assetImagePath: "assets/images/lodging.png",
      name: "Lodging",
      type: "lodging",
    ),
    Place(
      assetImagePath: "assets/images/meal_delivery.webp",
      name: "Meal Delivery",
      type: "meal_delivery",
    ),
    Place(
      assetImagePath: "assets/images/meal_takeaway.png",
      name: "Meal Takeaway",
      type: "meal_takeaway",
    ),
    Place(
      assetImagePath: "assets/images/mosque.png",
      name: "Mosque",
      type: "mosque",
    ),
    Place(
      assetImagePath: "assets/images/night_club.png",
      name: "Night Club",
      type: "night_club",
    ),
    Place(
      assetImagePath: "assets/images/parking.png",
      name: "Parking",
      type: "parking",
    ),
    Place(
      assetImagePath: "assets/images/pharmacy.png",
      name: "Pharmacy",
      type: "pharmacy",
    ),
    Place(
      assetImagePath: "assets/images/police.png",
      name: "Police",
      type: "police",
    ),
    Place(
      assetImagePath: "assets/images/school.webp",
      name: "School",
      type: "school",
    ),
    Place(
      assetImagePath: "assets/images/shopping_mall.png",
      name: "Shopping Mall",
      type: "shopping_mall",
    ),
    Place(
      assetImagePath: "assets/images/taxi_stand.png",
      name: "Taxi Stand",
      type: "taxi_stand",
    ),
    Place(
      assetImagePath: "assets/images/train_station.png",
      name: "Train Station",
      type: "train_station",
    ),
    Place(
      assetImagePath: "assets/images/university.png",
      name: "University",
      type: "university",
    ),
    Place(
      assetImagePath: "assets/images/veterinary_care.png",
      name: "Veterinary Care",
      type: "veterinary_care",
    ),
  ];

  List<Place> get placesList {
    return [..._placesList];
  }
}
