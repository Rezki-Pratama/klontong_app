import 'package:dartz/dartz.dart';
import 'package:klontong_project/core/data/exception.dart';
import 'package:klontong_project/core/data/source/remote_datasources/product_remote_datasource/product_datasource.dart';
import 'package:klontong_project/core/data/source/response/failure.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:klontong_project/core/domains/repository/product_repository.dart';
import 'package:klontong_project/utils/data_mapper.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> retrieveProduct(
      {int page = 1, String search = ''}) async {
    try {
      final result =
          await remoteDataSource.retrieveProduct(page: page, search: search);
      final data = DataMapper.mapProductsEntityToDomain(result);

      return Right(data);
    } on BadRequestException catch (e) {
      return Left(RequestFailure(e.toString()));
    } on ServerErrorException {
      return const Left(ServerFailure('Server returns error'));
    } on ParseDataException {
      return const Left(NoDataFailure(''));
    } on NoConnectionException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, void>> storeProduct(Product data) async {
    try {
      await remoteDataSource.storeProduct(data);
      return const Right(null);
    } on BadRequestException {
      return const Left(RequestFailure('Bad request'));
    } on ServerErrorException {
      return const Left(ServerFailure('Server returns error'));
    } on ParseDataException {
      return const Left(NoDataFailure(''));
    } on NoConnectionException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product data) async {
    try {
      await remoteDataSource.updateProduct(data);
      return const Right(null);
    } on BadRequestException {
      return const Left(RequestFailure('Bad request'));
    } on ServerErrorException {
      return const Left(ServerFailure('Server returns error'));
    } on ParseDataException {
      return const Left(NoDataFailure(''));
    } on NoConnectionException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await remoteDataSource.deleteProduct(id);
      return const Right(null);
    } on BadRequestException {
      return const Left(RequestFailure('Bad request'));
    } on ServerErrorException {
      return const Left(ServerFailure('Server returns error'));
    } on ParseDataException {
      return const Left(NoDataFailure(''));
    } on NoConnectionException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
