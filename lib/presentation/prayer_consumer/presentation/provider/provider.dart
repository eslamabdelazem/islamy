import 'package:flutter/cupertino.dart';
import 'package:islamy/core/extensions/error_handler_extension.dart';
import 'package:provider/provider.dart';
import '../../../../core/base_model.dart';
import '../../data/date_source.dart';
import '../../data/models/get_prayers_request.dart';
import '../../data/models/prayers_timing.dart';

class TimingProvider extends ChangeNotifier{
  TimingProvider(this.dataSource);
  final PrayerConsumerDataSource dataSource;

  String errorMsg = '';

  PrayerTiming? prayerTiming;
  Future<BaseModel<PrayerTiming>> getPrayersTiming(GetPrayersBasedChosenDateRequest request)async{
    return await dataSource.getNewPrayersBasedChosenDate(request);
  }
}