import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../generated/locale_keys.g.dart';

import '../../config/res/assets.gen.dart';
import '../../config/res/color_manager.dart';
import '../navifation/go.dart';
import '../widgets/app_text.dart';

class ImageHelper {
  static final ImagePicker _picker = ImagePicker();
  static final ImageCropper _cropper = ImageCropper();

  static Future<File?> takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    return await _cropImage(sourcePath: image.path);
  }

  static Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    return await _cropImage(sourcePath: image.path);
  }

  static Future<List<File>> pickMultiImages() async {
    final List<XFile> image = await _picker.pickMultiImage();
    if (image.isEmpty) return [];
    return image.map((e) => File(e.path)).toList();
  }

  static Future<File?> _cropImage({required String sourcePath}) async {
    CroppedFile? croppedFile = await _cropper.cropImage(
      sourcePath: sourcePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.primaryColor,
          toolbarWidgetColor: Colors.white,
          statusBarColor: AppColors.primaryColor,
          activeControlsWidgetColor: AppColors.primaryColor,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  static Future<File?> showImagePicker(Offset offset) async {
    if (Platform.isIOS) {
      return await _showIOSSheet();
    }
    return await _showAndroidMenuPopup(offset);
  }

  static Future<File?> _showIOSSheet() async {
    return await showCupertinoModalPopup<File?>(
      context: Go.navigatorKey.currentContext!,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select Image Source'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: AppText(
              LocaleKeys.camera,
              color: Colors.black,
            ),
            onPressed: () async {
              final image = await takePicture();
              Go.back(image);
            },
          ),
          CupertinoActionSheetAction(
            child: AppText(
              LocaleKeys.photo_library.tr(),
              color: Colors.black,
            ),
            onPressed: () async {
              final image = await pickImage();
              Go.back(image);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: Go.back,
          child: AppText(
            LocaleKeys.cancel,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  static Future<File?> _showAndroidMenuPopup(Offset offset) async {
    final context = Go.navigatorKey.currentContext!;

    final value = await showMenu<String?>(
      context: context,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      position: RelativeRect.fromDirectional(
        textDirection: Directionality.of(context),
        start: offset.dx / 2,
        top: offset.dy,
        end: 1.sw - offset.dx / 2,
        bottom: 10,
      ),
      items: [
        PopupMenuItem(
          value: 'camera',
          child: ListTile(
            leading: AppAssets.svg.camera.svg(
              height: 24.h,
              width: 24.w,
            ),
            visualDensity: VisualDensity.compact,
            title: Text(LocaleKeys.camera),
          ),
        ),
        PopupMenuItem(
          value: 'photo_library',
          child: ListTile(
            leading: AppAssets.svg.uploadImage.svg(
              height: 22.h,
              width: 22.w,
            ),
            visualDensity: VisualDensity.compact,
            title: Text(LocaleKeys.photo_library.tr()),
          ),
        ),
      ],
    );

    if (value == 'camera') {
      return await takePicture();
    } else if (value == 'photo_library') {
      return await pickImage();
    } else {
      return null;
    }
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (324, 214);

  @override
  String get name => '324 x 214 (3:2) Customized';
}
