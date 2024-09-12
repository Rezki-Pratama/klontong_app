import 'package:equatable/equatable.dart';

class ProductResponse extends Equatable {
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

  const ProductResponse({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.sku,
    required this.name,
    required this.description,
    required this.weight,
    required this.width,
    required this.length,
    required this.height,
    required this.image,
    required this.price,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        id: json["_id"],
        categoryId: json["CategoryId"] ?? 0,
        categoryName: json["categoryName"] ?? '',
        sku: json["sku"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        weight: json["weight"] ?? 0,
        width: json["width"] ?? 0,
        length: json["length"] ?? 0,
        height: json["height"] ?? 0,
        image: json["image"] ?? '',
        price: json["harga"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "CategoryId": categoryId,
        "categoryName": categoryName,
        "sku": sku,
        "name": name,
        "description": description,
        "weight": weight,
        "width": width,
        "length": length,
        "height": height,
        "image": image,
        "harga": price,
      };

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
        price,
      ];
}
