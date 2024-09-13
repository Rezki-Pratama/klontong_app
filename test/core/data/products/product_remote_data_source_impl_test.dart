import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_project/core/data/exception.dart';
import 'package:klontong_project/core/data/repository/product_repository/product_repository_impl.dart';
import 'package:klontong_project/core/data/source/remote_datasources/product_remote_datasource/product_datasource.dart';
import 'package:klontong_project/core/data/source/response/failure.dart';
import 'package:klontong_project/core/data/source/response/product_response.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:klontong_project/core/domains/repository/product_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_remote_data_source_impl_test.mocks.dart';

@GenerateMocks(
  [ProductRemoteDataSource],
)
void main() {
  late MockProductRemoteDataSource mockRemoteDataSource;
  late ProductRepository repository;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  const page = 1;

  const search = 'Ciki ciki';

  const tProductResponse = [
    ProductResponse(
      id: '66e17bbbfe837603e816b966',
      categoryId: 14,
      categoryName: 'Cemilan',
      sku: 'MHZVTK',
      name: 'Ciki ciki',
      description: 'Ciki ciki yang super enak, hanya di toko klontong kami',
      weight: 5,
      width: 5,
      length: 5,
      height: 5,
      image: 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b',
      price: 5000,
    )
  ];

  const tProduct = [
    Product(
      id: '66e17bbbfe837603e816b966',
      categoryId: 14,
      categoryName: 'Cemilan',
      sku: 'MHZVTK',
      name: 'Ciki ciki',
      description: 'Ciki ciki yang super enak, hanya di toko klontong kami',
      weight: 5,
      width: 5,
      length: 5,
      height: 5,
      image: 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b',
      price: 5000,
    )
  ];

  const tStoreProductResponse = ProductResponse(
    id: '66e17bbbfe837603e816b966',
    categoryId: 14,
    categoryName: 'Cemilan',
    sku: 'MHZVTK',
    name: 'Ciki ciki',
    description: 'Ciki ciki yang super enak, hanya di toko klontong kami',
    weight: 5,
    width: 5,
    length: 5,
    height: 5,
    image: 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b',
    price: 5000,
  );

  const tProductId = '66e17bbbfe837603e816b966';

  const tStoreProduct = Product(
    categoryId: 14,
    categoryName: 'Cemilan',
    sku: 'MHZVTK',
    name: 'Ciki ciki',
    description: 'Ciki ciki yang super enak, hanya di toko klontong kami',
    weight: 5,
    width: 5,
    length: 5,
    height: 5,
    image: 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b',
    price: 5000,
  );

  const tUpdateProduct = Product(
    id: '66e17bbbfe837603e816b966',
    categoryId: 14,
    categoryName: 'Cemilan',
    sku: 'MHZVTK',
    name: 'Ciki ciki',
    description: 'Ciki ciki yang super enak, hanya di toko klontong kami',
    weight: 5,
    width: 5,
    length: 5,
    height: 5,
    image: 'https://cf.shopee.co.id/file/7cb930d1bd183a435f4fb3e5cc4a896b',
    price: 5000,
  );

  group('Retrieve products', () {
    test(
      'Should return products array when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.retrieveProduct(page: page))
            .thenAnswer((_) async => tProductResponse);

        // act
        final result = await repository.retrieveProduct(page: page);

        // assert
        verify(mockRemoteDataSource.retrieveProduct(page: page));

        // define the expected result
        const expected = Right<Failure, List<Product>>(tProduct);

        // compare the actual content directly
        expect(result.isRight(), isTrue);
        final resultProducts = (result as Right<Failure, List<Product>>).value;
        final expectedProducts = (expected).value;

        expect(resultProducts, equals(expectedProducts));
      },
    );

    test(
      'Should return products array when a call to data with search value is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.retrieveProduct(page: page, search: search))
            .thenAnswer((_) async => tProductResponse);

        // act
        final result =
            await repository.retrieveProduct(page: page, search: search);

        // assert
        verify(
            mockRemoteDataSource.retrieveProduct(page: page, search: search));

        // define the expected result
        const expected = Right<Failure, List<Product>>(tProduct);

        // compare the actual content directly
        expect(result.isRight(), isTrue);
        final resultProducts = (result as Right<Failure, List<Product>>).value;
        final expectedProducts = (expected).value;

        expect(resultProducts, equals(expectedProducts));
        expect(resultProducts[0].name, equals(search));
      },
    );

    test(
      'Should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.retrieveProduct(page: page))
            .thenThrow(BadRequestException());

        // act
        final result = await repository.retrieveProduct(page: page);

        // assert
        verify(mockRemoteDataSource.retrieveProduct(page: page));

        // define the expected result
        const expected = Left<Failure, List<Product>>(
            RequestFailure('Invalid request: null'));

        // compare the actual content directly
        expect(result.isLeft(), isTrue);
        final resultFailure = (result as Left<Failure, List<Product>>).value;
        final expectedFailure = (expected).value;

        expect(resultFailure, equals(expectedFailure));
      },
    );

    test(
      'Should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockRemoteDataSource.retrieveProduct(page: page))
            .thenThrow(NoConnectionException());

        // act
        final result = await repository.retrieveProduct(page: page);

        // assert
        verify(mockRemoteDataSource.retrieveProduct(page: page));

        // define the expected result
        const expected = Left<Failure, List<Product>>(
          ConnectionFailure('Failed to connect to the network'),
        );

        // compare the actual content directly
        expect(result.isLeft(), isTrue);
        final resultFailure = (result as Left<Failure, List<Product>>).value;
        final expectedFailure = (expected).value;

        expect(resultFailure, equals(expectedFailure));
      },
    );
  });

  group('Store products', () {
    test(
      'Should return void when store data is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.storeProduct(tStoreProduct))
            .thenAnswer((_) async => tStoreProductResponse);

        // act
        final result = await repository.storeProduct(tStoreProduct);

        // assert
        verify(mockRemoteDataSource.storeProduct(tStoreProduct));

        // define the expected result
        const expected = Right<Failure, void>(null);

        // compare the actual content directly
        expect(result.isRight(), isTrue);
        final resultProducts = (result as Right<Failure, void>);

        expect(resultProducts, equals(expected));
      },
    );

    test(
      'Should return server failure when store to data is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.storeProduct(tStoreProduct))
            .thenThrow(BadRequestException());

        // act
        final result = await repository.storeProduct(tStoreProduct);

        // assert
        verify(mockRemoteDataSource.storeProduct(tStoreProduct));

        // define the expected result
        const expected = Left<Failure, void>(RequestFailure('Bad request'));

        // compare the actual content directly
        expect(result.isLeft(), isTrue);
        final resultFailure = (result as Left<Failure, void>).value;
        final expectedFailure = (expected).value;

        expect(resultFailure, equals(expectedFailure));
      },
    );

    test(
      'Should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockRemoteDataSource.storeProduct(tStoreProduct))
            .thenThrow(NoConnectionException());

        // act
        final result = await repository.storeProduct(tStoreProduct);

        // assert
        verify(mockRemoteDataSource.storeProduct(tStoreProduct));

        // define the expected result
        const expected = Left<Failure, void>(
          ConnectionFailure('Failed to connect to the network'),
        );

        // compare the actual content directly
        expect(result.isLeft(), isTrue);
        final resultFailure = (result as Left<Failure, void>).value;
        final expectedFailure = (expected).value;

        expect(resultFailure, equals(expectedFailure));
      },
    );
  });

  group('Update products data source', () {
    test(
      'Should return void when update data is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.updateProduct(tUpdateProduct))
            .thenAnswer((_) async => tStoreProductResponse);

        // act
        final result = await repository.updateProduct(tUpdateProduct);

        // assert
        verify(mockRemoteDataSource.updateProduct(tUpdateProduct));

        // define the expected result
        const expected = Right<Failure, void>(null);

        // compare the actual content directly
        expect(result.isRight(), isTrue);
        final resultProducts = (result as Right<Failure, void>);

        expect(resultProducts, equals(expected));
      },
    );

    test(
      'Should return server failure when store to data is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.updateProduct(tUpdateProduct))
            .thenThrow(BadRequestException());

        // act
        final result = await repository.updateProduct(tUpdateProduct);

        // assert
        verify(mockRemoteDataSource.updateProduct(tUpdateProduct));

        // define the expected result
        const expected = Left<Failure, void>(RequestFailure('Bad request'));

        // compare the actual content directly
        expect(result.isLeft(), isTrue);
        final resultFailure = (result as Left<Failure, void>).value;
        final expectedFailure = (expected).value;

        expect(resultFailure, equals(expectedFailure));
      },
    );

    test(
      'Should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockRemoteDataSource.updateProduct(tUpdateProduct))
            .thenThrow(NoConnectionException());

        // act
        final result = await repository.updateProduct(tUpdateProduct);

        // assert
        verify(mockRemoteDataSource.updateProduct(tUpdateProduct));

        // define the expected result
        const expected = Left<Failure, void>(
          ConnectionFailure('Failed to connect to the network'),
        );

        // compare the actual content directly
        expect(result.isLeft(), isTrue);
        final resultFailure = (result as Left<Failure, void>).value;
        final expectedFailure = (expected).value;

        expect(resultFailure, equals(expectedFailure));
      },
    );
  });

  group('Delete products', () {
    test(
      'Should return void when delete data is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteProduct(tProductId))
            .thenAnswer((_) async => tStoreProductResponse);

        // act
        final result = await repository.deleteProduct(tProductId);

        // assert
        verify(mockRemoteDataSource.deleteProduct(tProductId));

        // define the expected result
        const expected = Right<Failure, void>(null);

        // compare the actual content directly
        expect(result.isRight(), isTrue);
        final resultProducts = (result as Right<Failure, void>);

        expect(resultProducts, equals(expected));
      },
    );

    test(
      'Should return server failure when store to data is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteProduct(tProductId))
            .thenThrow(BadRequestException());

        // act
        final result = await repository.deleteProduct(tProductId);

        // assert
        verify(mockRemoteDataSource.deleteProduct(tProductId));

        // define the expected result
        const expected = Left<Failure, void>(RequestFailure('Bad request'));

        // compare the actual content directly
        expect(result.isLeft(), isTrue);
        final resultFailure = (result as Left<Failure, void>).value;
        final expectedFailure = (expected).value;

        expect(resultFailure, equals(expectedFailure));
      },
    );

    test(
      'Should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockRemoteDataSource.updateProduct(tUpdateProduct))
            .thenThrow(NoConnectionException());

        // act
        final result = await repository.updateProduct(tUpdateProduct);

        // assert
        verify(mockRemoteDataSource.updateProduct(tUpdateProduct));

        // define the expected result
        const expected = Left<Failure, void>(
          ConnectionFailure('Failed to connect to the network'),
        );

        // compare the actual content directly
        expect(result.isLeft(), isTrue);
        final resultFailure = (result as Left<Failure, void>).value;
        final expectedFailure = (expected).value;

        expect(resultFailure, equals(expectedFailure));
      },
    );
  });
}
