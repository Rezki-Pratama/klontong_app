import 'package:klontong_project/core/data/source/response/product_response.dart';
import 'package:klontong_project/core/domains/model/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductResponse>> retrieveProduct(int page);
  Future<ProductResponse> storeProduct(Product data);
  Future<void> updateProduct(Product data);
  Future<void> deleteProduct(String id);
}
