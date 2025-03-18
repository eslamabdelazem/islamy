enum PermissionClient {camera, storage, contacts, notification, location}

class PermissionProcessModel {
  PermissionClient permissionClient;
  Function() onPermissionGranted;
  Function() onPermissionDenied;
  String? messageOnDenied;
  PermissionProcessModel({
    required this.permissionClient,
    required this.onPermissionGranted,
    required this.onPermissionDenied,
    this.messageOnDenied,
  });
}