import 'package:floor/floor.dart';

@entity
class ProductEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? name;

  final String? description;

  final bool? isActive;

  ProductEntity(
      {
      // ignore: avoid_init_to_null
      this.id = null,
      this.name,
      this.description,
      this.isActive});
}
