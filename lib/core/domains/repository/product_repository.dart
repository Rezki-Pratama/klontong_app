import 'package:dartz/dartz.dart';
import 'package:klontong_project/core/data/source/response/failure.dart';
import 'package:klontong_project/core/domains/model/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> retrieveProduct(
      {int page = 1, String search = ''});
  Future<Either<Failure, void>> storeProduct(Product data);
  Future<Either<Failure, void>> updateProduct(Product data);
  Future<Either<Failure, void>> deleteProduct(String id);
}
