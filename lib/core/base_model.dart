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
  }) {
    return BaseModel(
      message: json['msg'] ?? '',
      data: jsonToModel != null ? jsonToModel(json['data']) : json['data'],
    );
  }
}
