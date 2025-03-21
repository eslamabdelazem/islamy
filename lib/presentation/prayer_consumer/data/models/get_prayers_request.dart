class GetPrayersBasedChosenDateRequest {

  String date;
  String lat;
  String lng;
  int method;

  GetPrayersBasedChosenDateRequest({
    required this.lat,
    required this.lng,
    this.method = 5,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'latitude': lat,
    'longitude': lng,
    'method': method,
  };
}