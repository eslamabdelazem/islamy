import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:islamy/core/extensions/error_handler_extension.dart';
import 'package:islamy/core/shared/base_status.dart';
import 'package:provider/provider.dart';
import '../../../../core/base_model.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/shared/models/location.dart';
import '../../../Settings/settings.dart';
import '../../data/date_source.dart';
import '../../data/models/get_prayers_request.dart';
import '../../data/models/prayers_timing.dart';

class TimingProvider extends ChangeNotifier{
  final PrayerConsumerDataSource dataSource = PrayerConsumerDataSource();

  BaseStatus status = BaseStatus.initial;
  String errorMsg = '';

  PrayerTiming? prayerTiming;

  LocationModel? location;
  Future<void> getLocation()async{
    location = await Helpers.handleGetLocation();
  }

  Future<void> getPrayersTiming(String date)async{
    status = BaseStatus.loading;
    await getLocation();
    final result = await dataSource.getNewPrayersBasedChosenDate(GetPrayersBasedChosenDateRequest(
        latLng: location != null?
        LatLng(location!.lat!.toDouble(), location!.lng!.toDouble()) :
        const LatLng(30, 30),
        date: date
    ));
    result.when(
          (success) {
            prayerTiming = success.data;
            status = BaseStatus.success;
          },
          (error) {
            errorMsg = error.message;
            status = BaseStatus.error;
          }
    );
    notifyListeners();
  }
}