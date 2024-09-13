import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:klontong_project/core/domains/repository/product_repository.dart';
import 'package:klontong_project/core/domains/usecase/product_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_use_case_test.mocks.dart';

@GenerateMocks(
  [
    ProductRepository,
  ],
)
void main() {
  late MockProductRepository mockProductRepository;
  late ProductUseCase usecase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = ProductUseCase(mockProductRepository);
  });

  const page = 1;

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

  const tProductId = '66e17bbbfe837603e816b966';

  group('Product Usecase', () {
    test(
      'Should retrieve products from the repository',
      () async {
        // arrange
        when(mockProductRepository.retrieveProduct(page: page))
            .thenAnswer((_) async => const Right(tProduct));

        // act
        final result = await usecase.paginate(page: page);

        // assert
        expect(result, equals(const Right(tProduct)));
      },
    );

    test(
      'Should store products from the repository',
      () async {
        // arrange
        when(mockProductRepository.storeProduct(tStoreProduct)).thenAnswer(
            // ignore: void_checks
            (_) async => const Right(tProduct));

        // act
        final result = await usecase.store(data: tStoreProduct);

        // assert
        expect(result, equals(const Right(tProduct)));
      },
    );

    test(
      'Should update products from the repository',
      () async {
        // arrange
        when(mockProductRepository.updateProduct(tUpdateProduct)).thenAnswer(
            // ignore: void_checks
            (_) async => const Right(tProduct));

        // act
        final result = await usecase.update(data: tUpdateProduct);

        // assert
        expect(result, equals(const Right(tProduct)));
      },
    );

    test(
      'Should delete products from the repository',
      () async {
        // arrange
        when(mockProductRepository.deleteProduct(tProductId)).thenAnswer(
            // ignore: void_checks
            (_) async => const Right(tProduct));

        // act
        final result = await usecase.delete(tProductId);

        // assert
        expect(result, equals(const Right(tProduct)));
      },
    );
  });
}
