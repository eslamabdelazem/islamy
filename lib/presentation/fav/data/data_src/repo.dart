import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:islamy/presentation/fav/data/data_src/data_source.dart';
import 'package:objectbox/objectbox.dart';

import '../../../../objectbox.g.dart';
import '../fav_model.dart';

class FavoritesRepository {
  final Box<FavoriteItem> _favoriteBox;

  FavoritesRepository(LocalDatabase objectBox) : _favoriteBox = objectBox.favoriteBox;

  // Add an item to favorites
  Future<int> addToFavorites(FavoriteItem item) async {
    return _favoriteBox.put(item);
  }

  void removeAll(){
    _favoriteBox.removeAll();
  }

  // Remove an item from favorites
  Future<bool> removeFromFavorites(int id) async {
    return _favoriteBox.remove(id);
  }

  void removeWhere({
    required int id,
    required String title,
}){
    final query = _favoriteBox.query(
        FavoriteItem_.id.equals(id).and(FavoriteItem_.title.equals(title))
    ).build().findFirst();
    log('found ${query?.title} ${query?.id}');
  }

  // Remove by itemId and type (useful when you don't have the ObjectBox ID)
  Future<int> removeByItemId(int itemId, String itemType) async {
    final query = _favoriteBox.query(
        FavoriteItem_.itemId.equals(itemId) &
        FavoriteItem_.itemType.equals(itemType)
    ).build();

    final items = query.find();
    query.close();

    if (items.isEmpty) return 0;

    int count = 0;
    for (var item in items) {
      if (_favoriteBox.remove(item.id)) count++;
    }

    return count;
  }

  // Check if an item is in favorites
  Future<bool> isFavorite(int itemId, String itemType) async {
    final query = _favoriteBox.query(
        FavoriteItem_.itemId.equals(itemId) &
        FavoriteItem_.itemType.equals(itemType)
    ).build();

    final count = query.count();
    query.close();

    return count > 0;
  }

  // Get all favorites
  List<FavoriteItem> getAllFavorites() {
    return _favoriteBox.getAll();
  }

  // Get favorites by type
  List<FavoriteItem> getFavoritesByType(String itemType) {
    final query = _favoriteBox.query(
        FavoriteItem_.itemType.equals(itemType)
    ).build();

    final results = query.find();
    query.close();

    return results;
  }

  // Get favorites sorted by date (newest first)
  // List<FavoriteItem> getFavoritesSortedByDate() {
  //   final query = _favoriteBox.query()
  //     ..order(FavoriteItem_.addedDate, flags: Order.descending)
  //     ..build();
  //
  //   final results = query.find();
  //   query.close();
  //
  //   return results;
  // }

  // Search favorites by title
  List<FavoriteItem> searchFavorites(String searchTerm) {
    final query = _favoriteBox.query(
        FavoriteItem_.title.contains(searchTerm, caseSensitive: false)
    ).build();

    final results = query.find();
    query.close();

    return results;
  }

  // Get the count of all favorites
  int getFavoritesCount() {
    return _favoriteBox.count();
  }

  // Clear all favorites
  int clearAllFavorites() {
    return _favoriteBox.removeAll();
  }
}