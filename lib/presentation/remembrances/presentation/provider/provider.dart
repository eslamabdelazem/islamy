import 'package:flutter/widgets.dart';
import 'package:islamy/core/shared/base_status.dart';

import '../../data/data_source.dart';

class RemembrancesProvider extends ChangeNotifier{

  BaseStatus baseStatus = BaseStatus.initial;
  List<String> remembrances = [];
  String errorMsg = '';

  Future<void> getRemembrances(RemembrancesType remembrancesType)async{
    remembrances = [];
    baseStatus = BaseStatus.loading;
    final result = await RemembrancesDataSource().getRemembrances(remembrancesType);
    result.when(
          (success) {
            baseStatus = BaseStatus.success;
            remembrances = success.data;
          },
          (error) {
            baseStatus = BaseStatus.error;
            errorMsg = error.message;
          },
    );
    notifyListeners();
  }
}