import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetPrayersBasedChosenDateRequest {

  String date;
  LatLng latLng;
  int method;

  GetPrayersBasedChosenDateRequest({
    required this.latLng,
    this.method = 5,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'latitude': latLng.latitude,
    'longitude': latLng.longitude,
    'method': method,
  };
}