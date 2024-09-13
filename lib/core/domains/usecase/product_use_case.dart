import 'package:dartz/dartz.dart';
import 'package:klontong_project/core/data/source/response/failure.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:klontong_project/core/domains/repository/product_repository.dart';

class ProductUseCase {
  final ProductRepository _repository;
  ProductUseCase(this._repository);

  Future<Either<Failure, List<Product>>> execute() async {
    return await _repository.retrieveProduct(page: 1);
  }

  Future<Either<Failure, List<Product>>> paginate(
      {int page = 1, String search = ''}) async {
    return await _repository.retrieveProduct(page: page, search: search);
  }

  Future<Either<Failure, void>> store({required Product data}) async {
    return await _repository.storeProduct(data);
  }

  Future<Either<Failure, void>> update({required Product data}) async {
    return await _repository.updateProduct(data);
  }

  Future<Either<Failure, void>> delete(String id) async {
    return await _repository.deleteProduct(id);
  }
}
