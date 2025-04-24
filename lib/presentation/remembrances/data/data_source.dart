import 'package:islamy/core/base_model.dart';
import 'package:islamy/core/extensions/error_handler_extension.dart';
import 'package:islamy/core/network/api_endpoints.dart';
import 'package:islamy/core/network/network_request.dart';
import 'package:islamy/core/network/network_service.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../config/res/constants_manager.dart';
import '../../../core/error/failure.dart';

enum RemembrancesType{morningRemembrances, eveningRemembrances, sleepRemembrances}

class RemembrancesDataSource{

  String getRemembrancesByType(RemembrancesType type){
    switch(type){
      case RemembrancesType.morningRemembrances:
        return 'morning_azkar';

      case RemembrancesType.eveningRemembrances:
        return 'evening_azkar';

      case RemembrancesType.sleepRemembrances:
        return 'sleep_azkar';
    }
  }

  Future<Result<BaseModel<List<String>>, Failure>> getRemembrances(RemembrancesType remembrancesType)async{
    final result = await sl<NetworkService>().callApi<List<String>>(
        NetworkRequest(
          method: RequestMethod.get,
          path: ConstantManager.baseUrlForRemembrances+ApiConstants.azkar,
        ),
      mapper: (json) => (json[getRemembrancesByType(remembrancesType)] as List)
          .map((e) => e['text'] as String)
          .toList(),
    ).handleCallbackWithFailure();

    return result;
  }
}