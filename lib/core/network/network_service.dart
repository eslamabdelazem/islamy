import '../base_model.dart';
import 'network_request.dart';

abstract interface class NetworkService {
  Future<BaseModel<Model>> callApi<Model>(
    NetworkRequest networkRequest, {
    Model Function(dynamic json)? mapper,
        String? secondKey
  });

  void setToken(String token);

  void removeToken();
}
