import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/extensions/context_extension.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/extensions/sized_box_helper.dart';
import '../../config/res/color_manager.dart';
import '../../generated/locale_keys.g.dart';
import '../helpers/validators.dart';
import 'app_text.dart';
import 'image_widgets/cached_image.dart';

enum DropDownType {
  menu,
  bottomsheet;
}

class DefaultDropDownField<T> extends StatelessWidget {
  final String Function(T?) itemAsString;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final T? selectedItem;
  final String? hint;
  final String? label;
  final Future<List<T>> Function(String)? asyncItems;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget Function(BuildContext, T?)? dropdownBuilder;
  final DropDownType dropDownType;
  final BorderRadius? borderRadius;
  final String Function(T)? itemImage;

  const DefaultDropDownField(
      {super.key,
      required this.itemAsString,
      this.asyncItems,
      this.validator,
      this.onChanged,
      this.hint,
      this.selectedItem,
      this.label,
      this.prefixIcon,
      this.dropdownBuilder,
      this.dropDownType = DropDownType.menu,
      this.itemImage,
      this.borderRadius,
      this.suffixIcon});

  PopupProps<T> _buildPopUpFromType(DropDownType type) {
    switch (type) {
      case DropDownType.menu:
        return PopupProps.menu(
            showSearchBox: true,
            constraints: BoxConstraints(
                maxHeight: 300.h, maxWidth: 400.w, minWidth: 350.w),
            showSelectedItems: true,
            loadingBuilder: (context, searchEntry) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            },
            itemBuilder: (context, item, isSelected) {
              return ListTile(
                title: Text(itemAsString(item),
                    style: TextStyle(
                      color: isSelected ? AppColors.primaryColor : AppColors.black,
                    )),
                leading: isSelected
                    ? const Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                      )
                    : const SizedBox.shrink(),
              );
            },
            searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
              hintText: LocaleKeys.search.tr(),
              prefixIcon: const Icon(Icons.search),
            )),
            menuProps: const MenuProps(
              backgroundColor: AppColors.white,
            ));

      case DropDownType.bottomsheet:
        return PopupProps.bottomSheet(
          showSearchBox: true,
          constraints: BoxConstraints(
              maxHeight: 300.h, maxWidth: 400.w, minWidth: 350.w),
          showSelectedItems: true,
          loadingBuilder: (context, searchEntry) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
          itemBuilder: (context, item, isSelected) {
            return ListTile(
                title: Text(itemAsString(item),
                    style: TextStyle(
                      color: isSelected ? AppColors.primaryColor : AppColors.black,
                    )),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected)
                      const Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                      )
                    else
                      25.szW,
                    10.szW,
                    if (itemImage != null)
                      CachedImage(
                              url: itemImage!(item),
                              height: 20.h,
                              width: 30.w,
                              borderRadius: BorderRadius.circular(3),
                              fit: BoxFit.fill)
                          .paddingSymmetric(horizontal: 2.w),
                  ],
                ));
          },
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
            hintText: LocaleKeys.search,
            prefixIcon: const Icon(Icons.search),
          )),
          bottomSheetProps: const BottomSheetProps(
            backgroundColor: AppColors.white,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          AppText(
            label!,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        5.szH,
        Theme(
          data: context.theme.copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: DropdownSearch<T>(
              validator: validator ?? Validators.validateDropDown,
              onChanged: onChanged,
              selectedItem: selectedItem,
              clearButtonProps: const ClearButtonProps(
                  color: Colors.black,
                  isVisible: false,
                  padding: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft),
              dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: const TextStyle(color: Colors.black),
                  dropdownSearchDecoration: InputDecoration(
                    prefixIcon: prefixIcon,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
                    hintText: hint,
                    hintStyle: const TextStyle(color: AppColors.border),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.border),
                      borderRadius: borderRadius ?? BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                      borderRadius: borderRadius ?? BorderRadius.circular(24),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                      borderRadius: borderRadius ?? BorderRadius.circular(24),
                    ),
                  )),
              dropdownBuilder: dropdownBuilder,
              compareFn: (item, selectedItem) => item == selectedItem,
              dropdownButtonProps: DropdownButtonProps(
                padding: EdgeInsets.zero,
                icon: suffixIcon ?? const Icon(Icons.arrow_drop_down),
                visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
              ),
              autoValidateMode: AutovalidateMode.onUserInteraction,
              itemAsString: itemAsString,
              popupProps: _buildPopUpFromType(dropDownType),
              asyncItems: asyncItems),
        ),
      ],
    );
  }
}
