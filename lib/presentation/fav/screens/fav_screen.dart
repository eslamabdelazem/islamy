import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/config/res/color_manager.dart';
import 'package:islamy/core/extensions/sized_box_helper.dart';
import 'package:islamy/core/helpers/helpers.dart';
import 'package:islamy/generated/assets.dart';
import 'package:islamy/generated/locale_keys.g.dart';
import 'package:islamy/presentation/fav/data/data_src/data_source.dart';
import 'package:islamy/presentation/fav/data/fav_model.dart';
import 'package:islamy/presentation/remembrances/presentation/widgets/remembrances_element.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/app_text.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {

  List<FavoriteItem> items = [];
  void _getAllFavorites() async {
    items = Helpers.favoritesRepository!.getAllFavorites();
    log('the items are $items');
  }

  @override
  void initState() {
    _getAllFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                setState(() => favItems.value.clear());
              },
              child: AppText(LocaleKeys.delete_all.tr(), color: Colors.red,),
          )
        ],
          centerTitle: true,
          title: AppText(LocaleKeys.favorites.tr(), color: AppColors.primaryColor, fontWeight: FontWeight.w500, fontSize: 16.sp,)),
      body: ValueListenableBuilder(
        valueListenable: favItems,
        builder:(context, value, child) => value.isEmpty?
        Center(child: AppText(LocaleKeys.no_data_found.tr(), fontSize: 16.sp,)) : ListView.separated(
            itemBuilder: (context, index) => RemembrancesElement(
              isFav: true,
              remembrancesText: value[index].title,
              index: index,
            ),
            separatorBuilder: (context, index) => 10.szH,
            itemCount: value.length
        ),
      ),
    );
  }
}
