import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/extensions/padding_extension.dart';
import 'package:islamy/core/helpers/helpers.dart';
import 'package:islamy/core/widgets/app_text.dart';
import 'package:islamy/generated/assets.dart';
import 'package:islamy/presentation/fav/data/fav_model.dart';

import '../../../fav/data/data_src/data_source.dart';

class RemembrancesElement extends StatefulWidget {
  final bool isFav;
  final String remembrancesText;
  final int index;
  const RemembrancesElement({super.key,
    required this.remembrancesText,
    required this.index,
    this.isFav = false
  });

  @override
  State<RemembrancesElement> createState() => _RemembrancesElementState();
}

class _RemembrancesElementState extends State<RemembrancesElement> {
  bool isFav = false;

  void _makeChangesInDatabase(FavoriteItem item){
    if(isFav){
      favItems.value.add(item);
      _notify();
      // Helpers.favoritesRepository?.addToFavorites(
      //     FavoriteItem(
      //         itemId: widget.index,
      //         title: widget.remembrancesText,
      //         itemType: 'any',
      //         description: 'any'
      //     )
      // );

    }else{
      _removeItemFromFav(item);
    }
  }

  void _changeFavState(FavoriteItem item){
    setState(() => isFav = !isFav);
    _makeChangesInDatabase(item);

  }

  void _notify(){
    favItems.notifyListeners();
  }

  void _removeItemFromFav(FavoriteItem item){
    favItems.value.remove(item);
    _notify();
  }

  // void _removeItemFromFav(){
  //   Helpers.favoritesRepository?.removeWhere(
  //       id: widget.index,
  //       title: widget.remembrancesText
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: Column(
        spacing: 10.h,
        children: [
          Image.asset(Assets.imagesRemembrancesSeparator),
          AppText(widget.remembrancesText),
          Image.asset(Assets.imagesRemembrancesSeparator),
          Row(
            children: [
              const Expanded(child: Divider()),
              if(widget.isFav)
                IconButton(
                    onPressed: () => _removeItemFromFav(FavoriteItem(
                        itemId: widget.index,
                        itemType: 'itemType',
                        title: widget.remembrancesText,
                        description: 'description'
                    )),
                    icon: const Icon(Icons.delete, color: Colors.red)
                )
              else
                IconButton(
                    onPressed: () => _changeFavState(
                        FavoriteItem(
                            itemId: widget.index,
                            itemType: 'itemType',
                            title: widget.remembrancesText,
                            description: 'description'
                        )),
                    icon: isFav?
                    const Icon(Icons.favorite, color: Colors.red) :
                    const Icon(Icons.favorite_border)
                )
            ],
          )
        ],
      ).paddingAll(10.r),
    );
  }
}
