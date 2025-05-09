import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class FavoriteItem extends Equatable{
  @Id()
  int id = 0; // ObjectBox will auto-increment this ID

  // The actual itemId from your main data (could be product ID, article ID, etc.)
  int itemId;

  // Item type for differentiation (e.g., "product", "article", "recipe")
  String itemType;

  // Basic item details for quick access without loading the full item
  String title;
  String description;
  String imageUrl;

  // Additional metadata - optional
  @Property(type: PropertyType.date)
  DateTime addedDate;

  // You can add more fields as needed for your specific use case

  FavoriteItem({
    this.id = 0,
    required this.itemId,
    required this.itemType,
    required this.title,
    required this.description,
    this.imageUrl = '',
  }) : addedDate = DateTime.now();

  @override
  List<Object?> get props => [
    id,
    itemId,
    itemType,
    title,
    description,
    imageUrl
  ];
}