import 'package:islamy/core/base_model.dart';
import 'package:islamy/core/error/failure.dart';
import 'package:islamy/core/extensions/error_handler_extension.dart';
import 'package:islamy/core/network/api_endpoints.dart';
import 'package:islamy/core/network/network_service.dart';
import 'package:islamy/presentation/prayer_consumer/data/models/prayers_timing.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../config/res/constants_manager.dart';
import '../../../core/network/network_request.dart';
import 'models/get_prayers_request.dart';

class PrayerConsumerDataSource{
  Future<BaseModel<PrayerTiming>> getNewPrayersBasedChosenDate(GetPrayersBasedChosenDateRequest request)async{
    return await sl<NetworkService>().callApi<PrayerTiming>(
      NetworkRequest(
          path: ApiConstants.prayerTimesForSpecificDate+request.date.toString(),
          method: RequestMethod.get,
          queryParameters: request.toJson()
        ),
      secondKey: ApiResponseKeys.timings,
      mapper: (json) => PrayerTiming.fromJson(json),
    );
  }
}