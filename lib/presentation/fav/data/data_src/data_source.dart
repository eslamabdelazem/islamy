import 'package:flutter/cupertino.dart';
import 'package:objectbox/internal.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../../../../objectbox.g.dart';
import '../fav_model.dart';

ValueNotifier<List<FavoriteItem>> favItems = ValueNotifier<List<FavoriteItem>>([]);
class LocalDatabase {
  /// The ObjectBox store of this app.
  late final Store _store;

  // Boxes for each entity type
  late final Box<FavoriteItem> favoriteBox;

  LocalDatabase._create(this._store) {
    favoriteBox = Box<FavoriteItem>(_store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<LocalDatabase> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    try{
      final store = openStore(directory: path.join(docsDir.path, "objectbox"));
      return LocalDatabase._create(store);
    }catch(e){
      final store = openStore(directory: path.join(docsDir.path, DateTime.now().toString()));
      return LocalDatabase._create(store);
    }
  }

  // Get store for direct DB operations
  Store get store => _store;
}