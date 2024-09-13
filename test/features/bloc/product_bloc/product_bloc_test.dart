import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_project/core/data/source/response/failure.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:klontong_project/core/domains/usecase/product_use_case.dart';
import 'package:klontong_project/features/bloc/product_bloc/product_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks(
  [ProductUseCase],
)
void main() {
  late MockProductUseCase mockProductUseCase;
  late ProductBloc productBloc;

  setUp(() {
    mockProductUseCase = MockProductUseCase();
    productBloc = ProductBloc(mockProductUseCase);
  });

  const page = 1;

  const search = 'Ciki ciki';

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

  test(
    'Initial state should be ProductState',
    () {
      expect(productBloc.state, const ProductState());
    },
  );

  blocTest<ProductBloc, ProductState>(
    'Should emit [loading, has data] when data is gotten successfully',
    build: () {
      when(mockProductUseCase.paginate(page: page))
          .thenAnswer((_) async => const Right(tProduct));
      return productBloc;
    },
    act: (bloc) => bloc.add(const RetrieveProduct(isScroll: false)),
    wait: const Duration(milliseconds: 1000),
    expect: () => [
      const ProductState(status: ProductStatus.loadingRetrieve),
      const ProductState(status: ProductStatus.loaded, data: tProduct)
    ],
    verify: (bloc) {
      verify(mockProductUseCase.paginate(page: page));
    },
  );

  blocTest<ProductBloc, ProductState>(
    'Should emit [loading, has data] with search value when data is gotten successfully',
    build: () {
      when(mockProductUseCase.paginate(page: page, search: search))
          .thenAnswer((_) async => const Right(tProduct));
      return productBloc;
    },
    act: (bloc) =>
        bloc.add(const RetrieveProduct(isScroll: false, search: search)),
    wait: const Duration(milliseconds: 1000),
    expect: () => [
      const ProductState(status: ProductStatus.loadingRetrieve),
      const ProductState(status: ProductStatus.loaded, data: tProduct)
    ],
    verify: (bloc) {
      verify(mockProductUseCase.paginate(page: page, search: search));
    },
  );

  blocTest<ProductBloc, ProductState>(
    'Should emit [loading, error] when get data is unsuccessful',
    build: () {
      when(mockProductUseCase.paginate(page: page))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const RetrieveProduct(isScroll: false)),
    expect: () => [
      const ProductState(status: ProductStatus.loadingRetrieve),
      const ProductState(
          status: ProductStatus.errorRetrieve, message: 'server failure')
    ],
    verify: (bloc) {
      verify(mockProductUseCase.paginate(page: page));
    },
  );

  blocTest<ProductBloc, ProductState>(
    'Should emit [loading, stored] when store data is successfully',
    build: () {
      when(mockProductUseCase.store(data: tStoreProduct))
          .thenAnswer((_) async => const Right(null));
      return productBloc;
    },
    act: (bloc) => bloc.add(const StoreProduct(data: tStoreProduct)),
    wait: const Duration(milliseconds: 1000),
    expect: () => [
      const ProductState(status: ProductStatus.loadingStore),
      const ProductState(
          status: ProductStatus.stored, data: [], message: 'stored successfuly')
    ],
    verify: (bloc) {
      verify(mockProductUseCase.store(data: tStoreProduct));
    },
  );

  blocTest<ProductBloc, ProductState>(
    'Should emit [loading, error] when store data is unsuccessful',
    build: () {
      when(mockProductUseCase.store(data: tStoreProduct))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const StoreProduct(data: tStoreProduct)),
    expect: () => [
      const ProductState(status: ProductStatus.loadingStore),
      const ProductState(
          status: ProductStatus.errorStore, message: 'server failure')
    ],
    verify: (bloc) {
      verify(mockProductUseCase.store(data: tStoreProduct));
    },
  );

  blocTest<ProductBloc, ProductState>(
    'Should emit [loading, update] when update data is successfully',
    build: () {
      when(mockProductUseCase.update(data: tUpdateProduct))
          .thenAnswer((_) async => const Right(null));
      return productBloc;
    },
    act: (bloc) => bloc.add(const UpdateProduct(data: tUpdateProduct)),
    wait: const Duration(milliseconds: 1000),
    expect: () => [
      const ProductState(status: ProductStatus.loadingUpdate),
      const ProductState(
          status: ProductStatus.updated,
          data: [],
          message: 'updated successfuly')
    ],
    verify: (bloc) {
      verify(mockProductUseCase.update(data: tUpdateProduct));
    },
  );

  blocTest<ProductBloc, ProductState>(
    'Should emit [loading, error] when update data is unsuccessful',
    build: () {
      when(mockProductUseCase.update(data: tUpdateProduct))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return productBloc;
    },
    act: (bloc) => bloc.add(const UpdateProduct(data: tUpdateProduct)),
    expect: () => [
      const ProductState(status: ProductStatus.loadingUpdate),
      const ProductState(
          status: ProductStatus.errorUpdate, message: 'server failure')
    ],
    verify: (bloc) {
      verify(mockProductUseCase.update(data: tUpdateProduct));
    },
  );
}
