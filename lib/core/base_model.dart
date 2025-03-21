class BaseModel<T> {
  final String message;
  final T data;

  BaseModel({
    required this.message,
    required this.data,
  });

  factory BaseModel.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic json)? jsonToModel,
        String? secondKey
  }) {
    return BaseModel(
      message: json['status'] ?? '',
      data: jsonToModel != null ?
      secondKey != null? jsonToModel(json['data'][secondKey]) : jsonToModel(json['data']) :
      json['data'],
    );
  }
}
