import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/extensions/indexed_map.dart';
import 'package:islamy/core/extensions/sized_box_helper.dart';
import '../../../config/res/color_manager.dart';
import '../../helpers/image_helper.dart';
import '../text_fields/default_text_field.dart';
import 'cached_image.dart';

enum UploadImageType { single, multi }

class UploadImageWidget extends StatefulWidget {
  final List<int>? removedImages;
  final Widget? tappedItem;
  final Function(List<File>)? onUpload;
  final UploadImageType uploadImageType;

  const UploadImageWidget(
      {super.key,
      this.removedImages,
      this.tappedItem,
      this.onUpload,
      this.uploadImageType = UploadImageType.single});

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  final imageValue = ValueNotifier<List<dynamic>>([]);
  void _pickMultiImages() async {
    final images = await ImageHelper.pickMultiImages();
    if (images.isEmpty) return;
    _updateImageValue(images);
    _notifyUpload(images);
  }

  void _pickSingleImage() async {
    final image = await ImageHelper.pickImage();
    if (image == null) return;
    _updateImageValue([image]);
    _notifyUpload([image]);
  }

  void _updateImageValue(List<File> images) {
    if (widget.uploadImageType == UploadImageType.single) {
      imageValue.value = List.from(images);
    } else {
      imageValue.value = List.from(imageValue.value..addAll(images));
    }
  }

  void _notifyUpload(List<File> images) {
    if (widget.onUpload != null) {
      widget.onUpload?.call(imageValue.value.whereType<File>().toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.tappedItem != null) ...{
          GestureDetector(
            onTap: () {
              if (widget.uploadImageType == UploadImageType.single) {
                _pickSingleImage();
              } else {
                _pickMultiImages();
              }
            },
            child: widget.tappedItem! is DefaultTextField
                ? AbsorbPointer(child: widget.tappedItem!)
                : widget.tappedItem!,
          ),
        },
        ValueListenableBuilder(
          valueListenable: imageValue,
          builder: (context, value, child) {
            return Column(
              children: [
                if (value.isNotEmpty) 10.szH,
                Wrap(
                  spacing: 8.0.w,
                  runSpacing: 8.0.h,
                  children: value.indexedMap((index, item) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: item is String
                                ? CachedImage(
                                    url: item,
                                    width: 70.0.w,
                                    height: 70.0.h,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    item,
                                    width: 70.0.w,
                                    height: 70.0.h,
                                    fit: BoxFit.cover,
                                  )),
                        PositionedDirectional(
                          top: 3,
                          end: 3,
                          child: GestureDetector(
                            onTap: () {
                              imageValue.value =
                                  List.from(imageValue.value..removeAt(index));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
