import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final int categoryId;
  final String categoryName;
  final String sku;
  final String name;
  final String description;
  final int weight;
  final int width;
  final int length;
  final int height;
  final String image;
  final int price;
  const Product({
    this.id = '',
    required this.categoryId,
    this.categoryName = '',
    this.sku = '',
    this.name = '',
    this.description = '',
    this.weight = 0,
    this.width = 0,
    this.length = 0,
    this.height = 0,
    this.image = '',
    this.price = 0,
  });

  @override
  List<Object?> get props => [
        id,
        categoryId,
        categoryName,
        sku,
        name,
        description,
        weight,
        width,
        length,
        height,
        image,
        price
      ];
}
