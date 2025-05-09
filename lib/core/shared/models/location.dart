class LocationModel{
  num? lat;
  num? lng;
  String? countryName;
  String? street;
  String? isoCountryCode;
  String? postalCode;
  String? administrativeArea;
  String? subAdministrativeArea;
  String? locality;
  String? subLocality;
  String? thoroughfare;
  String? subThoroughfare;

  LocationModel({
    this.lng,
    this.lat,
    this.countryName,
    this.street,
    this.isoCountryCode,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare
  });

  factory LocationModel.fromJson(Map<String, dynamic> json){
    return LocationModel(
      lat: json['lat'],
      lng: json['lng'],
      countryName: json['name'],
      street: json['street'],
      isoCountryCode: json['isoCountryCode'],
      postalCode: json['postalCode'],
      administrativeArea: json['administrativeArea'],
      subAdministrativeArea: json['subAdministrativeArea'],
      locality: json['locality'],
      subLocality: json['subLocality'],
      thoroughfare: json['thoroughfare'],
      subThoroughfare: json['subThoroughfare'],
    );
  }

  Map<String, dynamic> toJson() => {
    'lat' : lat,
    'lng' : lng,
    'name': countryName,
    'street': street,
    'isoCountryCode': isoCountryCode,
    'postalCode': postalCode,
    'administrativeArea': administrativeArea,
    'subAdministrativeArea': subAdministrativeArea,
    'locality': locality,
    'subLocality': subLocality,
    'thoroughfare': thoroughfare,
    'subThoroughfare': subThoroughfare,
  };
}