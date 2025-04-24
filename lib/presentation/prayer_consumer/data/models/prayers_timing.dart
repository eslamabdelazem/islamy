class PrayerTiming{
  final String fajr;
  final String sunrise;
    final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstthird;
  final String lastthird;

  PrayerTiming({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory PrayerTiming.fromJson(Map<String, dynamic> json) => PrayerTiming(
    fajr: json['Fajr'],
    sunrise: json['Sunrise'],
    dhuhr: json['Dhuhr'],
    asr: json['Asr'],
    sunset: json['Sunset'],
    maghrib: json['Maghrib'],
    isha: json['Isha'],
    imsak: json['Imsak'],
    midnight: json['Midnight'],
    firstthird: json['Firstthird'],
    lastthird: json['Lastthird'],
  );
}