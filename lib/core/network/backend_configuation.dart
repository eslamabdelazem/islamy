enum BackendType { php, asp }

extension BackendTypeX on BackendType {
  bool get isPhp => this == BackendType.php;
  bool get isAsp => this == BackendType.asp;

}

class BackendConfiguation {
  static BackendType _instance = BackendType.php;

  static BackendType get type => _instance;

  static void setBackendType(BackendType type) {
    _instance = type;
  }
}
