import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:share_plus/share_plus.dart';
import '../../config/language/locale_keys.g.dart';
import '../../config/res/app_sizes.dart';
import '../../config/res/color_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import '../navifation/go.dart';
import '../widgets/custom_loading.dart';
import '../widgets/custom_messages.dart';
import 'check_permission/model.dart';

enum AppBackgroundColors {white, mintGreen}

class Helpers {

  static bool isBlocProvided<T extends StateStreamableSource>(BuildContext context) {
    try {
      BlocProvider.of<T>(context, listen: false);
      return true;
    } catch (e) {
      return false;
    }
  }


  static Color setScaffoldBackgroundColor(AppBackgroundColors appBackgroundColor){
    late Color newBackgroundColor;
    newBackgroundColor = appBackgroundColor == AppBackgroundColors.white?
    Colors.white : AppColors.scaffoldBackgroundMintGreen;
    return newBackgroundColor;
  }

  static String get deviceType => Platform.isIOS? "ios" : "android";

  static late Permission permission;

  static Future<void> checkPermission(PermissionProcessModel processModel)async {
    switch(processModel.permissionClient) {
      case PermissionClient.camera:
        permission = Permission.camera;

      case PermissionClient.storage:
        permission = Permission.storage;

      case PermissionClient.contacts:
        permission = Permission.contacts;

      case PermissionClient.notification:
        permission = Permission.notification;

      case PermissionClient.location:
        permission = Permission.location;
    }

    await askForPermission(
        onPermissionGranted: processModel.onPermissionGranted,
        onPermissionDenied: processModel.onPermissionDenied
    );
  }

  static Future<void> askForPermission({
    required Function() onPermissionGranted,
    required Function() onPermissionDenied,
    String? messageOnDenied,
  })async {
    bool status = await permission.status.isGranted;
    if(!status) {
      PermissionStatus status = await permission.request();
      switch(status) {
        case PermissionStatus.granted:
          onPermissionGranted();

        default:
          onPermissionDenied();
          if(messageOnDenied != null) {
            MessageUtils.showSimpleToast(msg: messageOnDenied);
          }
          openAppSettings();
      }
    }
    else{
      onPermissionGranted();
    }
  }

  static Color adjustColor(Color color, {double amount = 0.1}) {
    final hslColor = HSLColor.fromColor(color);
    final adjustedLightness = (hslColor.lightness + amount).clamp(0.0, 1.0);
    return hslColor.withLightness(adjustedLightness).toColor();
  }

  static Future<File?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      return imageFile;
    }
    return null;
  }

  static Future<List<File>> getImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> result = await picker.pickMultiImage();
    if (result.isNotEmpty) {
      List<File> files = result.map((e) => File(e.path)).toList();
      return files;
    } else {
      return [];
    }
  }

  static Future<File?> getImageFromCameraOrDevice() async {
    final ImagePicker picker = ImagePicker();
    File? image;
    await showModalBottomSheet(
        context: Go.navigatorKey.currentContext!,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(LocaleKeys.photoLibrary),
                  onTap: () async {
                    final currentImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (currentImage != null) {
                      image = File(currentImage.path);
                    }
                    Go.back();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(LocaleKeys.camera),
                  onTap: () async {
                    final currentImage =
                        await picker.pickImage(source: ImageSource.camera);
                    if (currentImage != null) {
                      image = File(currentImage.path);
                    }
                    Go.back();
                  },
                ),
              ],
            ).paddingAll(AppPadding.pH10),
          );
        });
    return image;
  }

  static void shareApp(url) {
    CustomLoading.showFullScreenLoading();
    Share.share(url).whenComplete(() {
      CustomLoading.hideFullScreenLoading();
    });
  }

  static Future<void> changeAppLang(BuildContext context, {required Locale newLang})async {
    context.setLocale(newLang);
  }
}

// class LauncherHelper {
//   static void launchURL({required String url}) async {
//     if (!url.toString().startsWith("https")) {
//       url = "https://$url";
//     }
//     await launchUrl(Uri.parse(url));
//   }
//
//   static void launchWhatsApp(String phone) async {
//     String message = 'مرحبا بك';
//     if (phone.startsWith("00966")) {
//       phone = phone.substring(5);
//     }
//     var whatsAppUrl = "whatsapp://send?phone=+966$phone&text=$message";
//     debugPrint(whatsAppUrl);
//     if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
//       await launchUrl(Uri.parse(whatsAppUrl));
//     } else {
//       throw LocaleKeys.exceptionError;
//     }
//   }
//
//   static String getDeviceType() {
//     if (Platform.isIOS) {
//       return 'ios';
//     } else {
//       return 'android';
//     }
//   }
// }
