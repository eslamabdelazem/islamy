import 'package:flutter/cupertino.dart';
import 'package:islamy/core/extensions/error_handler_extension.dart';
import 'package:islamy/core/shared/base_status.dart';
import 'package:provider/provider.dart';
import '../../../../core/base_model.dart';
import '../../data/date_source.dart';
import '../../data/models/get_prayers_request.dart';
import '../../data/models/prayers_timing.dart';

class TimingProvider extends ChangeNotifier{
  final PrayerConsumerDataSource dataSource = PrayerConsumerDataSource();

  BaseStatus status = BaseStatus.initial;
  String errorMsg = '';

  PrayerTiming? prayerTiming;
  Future<void> getPrayersTiming(GetPrayersBasedChosenDateRequest request)async{
    status = BaseStatus.loading;
    final result = await dataSource.getNewPrayersBasedChosenDate(request);
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