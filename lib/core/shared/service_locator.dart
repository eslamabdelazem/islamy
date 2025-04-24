import '../../../config/res/constants_manager.dart';
import '../network/dio_service.dart';
import '../network/network_service.dart';


void setUpServiceLocator() {
  setUpGeneralDependencies();
}

void setUpGeneralDependencies() {
  sl.registerLazySingleton<NetworkService>(
        () => DioService(),
  );

  // sl.registerLazySingleton<UserCubit>(
  //       () => UserCubit(),
  // );
  //
  // sl.registerFactory<NotificationService>(
  //       () => NotificationService(),
  // );
}
