import 'package:klontong_project/core/data/source/response/product_response.dart';
import 'package:klontong_project/core/domains/model/product.dart';

class DataMapper {
  static ProductResponse mapProductDomainToEntity(Product input) =>
      ProductResponse(
          id: input.id,
          categoryId: input.categoryId,
          categoryName: input.categoryName,
          sku: input.sku,
          name: input.name,
          description: input.description,
          weight: input.weight,
          width: input.width,
          length: input.length,
          height: input.height,
          image: input.image,
          price: input.price);

  static List<Product> mapProductsEntityToDomain(List<ProductResponse> input) {
    return input.map((it) {
      return Product(
          id: it.id,
          categoryId: it.categoryId,
          categoryName: it.categoryName,
          sku: it.sku,
          name: it.name,
          description: it.description,
          weight: it.weight,
          width: it.width,
          length: it.length,
          height: it.height,
          image: it.image,
          price: it.price);
    }).toList();
  }
}
