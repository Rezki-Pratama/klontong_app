import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:klontong_project/core/data/exception.dart';
import 'package:klontong_project/core/data/source/remote/api_base_helper.dart';
import 'package:klontong_project/core/data/source/remote_datasources/product_remote_datasource/product_datasource.dart';
import 'package:klontong_project/core/data/source/remote_datasources/product_remote_datasource/product_datasource_impl.dart';
import 'package:klontong_project/core/data/source/remote_datasources/product_remote_datasource/product_urls.dart';
import 'package:klontong_project/core/data/source/response/product_response.dart';
import 'package:klontong_project/core/domains/model/product.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../json_reader.dart';
import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks(
  [InterceptedClient],
)
void main() {
  late MockInterceptedClient mockHttpClient;
  late ProductRemoteDataSource dataSource;

  setUp(() {
    mockHttpClient = MockInterceptedClient();
    final apiBaseHelper = ApiBaseHelper(client: mockHttpClient);
    dataSource = ProductRemoteDataSourceImpl(apiBaseHelper: apiBaseHelper);
  });

  group('Retrieve products', () {
    const page = 1;
    final List<dynamic> jsonMap = json.decode(
      readJson('dummy_data/products/dummy_products_response.json'),
    );

    final tProductResponse = List<ProductResponse>.from(
      jsonMap.map<ProductResponse>(
        (dynamic i) => ProductResponse.fromJson(i),
      ),
    );

    final tProductResponseNoData = [];

    test(
      'Should return products response list when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse(ProductUrls.product),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data/products/dummy_products_response.json'),
              HttpStatus.ok),
        );

        // act
        final result = await dataSource.retrieveProduct(page);

        // assert
        expect(result, equals(tProductResponse));
      },
    );

    test(
      'Should throw a no data when the response code is 200 but there is no data',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse(ProductUrls.product),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
              readJson(
                  'dummy_data/products/dummy_products_no_data_response.json'),
              HttpStatus.ok),
        );
        // act
        final result = await dataSource.retrieveProduct(page);

        // assert
        expect(result, tProductResponseNoData);
      },
    );

    test(
      'Should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(
            Uri.parse(ProductUrls.product),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response('', 404),
        );

        // act
        final call = dataSource.retrieveProduct(page);

        // assert
        expect(() => call, throwsA(isA<BadRequestException>()));
      },
    );
  });

  group('Store products', () {
    final Map<String, dynamic> jsonMap = json
        .decode(readJson('dummy_data/products/dummy_product_response.json'));

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

    final tProductResponse = ProductResponse.fromJson(jsonMap);

    test(
      'Should return product response when the response code is 201',
      () async {
        // arrange
        when(
          mockHttpClient.post(
            Uri.parse(ProductUrls.product),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/products/dummy_product_response.json'),
            HttpStatus.created,
          ),
        );

        // act
        final result = await dataSource.storeProduct(tStoreProduct);

        // assert
        expect(result, equals(tProductResponse));
      },
    );

    test(
      'Should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.post(
            Uri.parse(ProductUrls.product),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('{}', 404),
        );

        // act
        final call = dataSource.storeProduct(tStoreProduct);

        // assert
        expect(() => call, throwsA(isA<BadRequestException>()));
      },
    );
  });

  group('Update products', () {
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
      'Should return product response when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.put(
            Uri.parse('${ProductUrls.product}/${tUpdateProduct.id}'),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            '',
            HttpStatus.ok,
          ),
        );

        // act
        await dataSource.updateProduct(tUpdateProduct);

        // assert
        expect(null, equals(null));
      },
    );

    test(
      'Should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.put(
            Uri.parse('${ProductUrls.product}/${tUpdateProduct.id}'),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) async => http.Response('{}', 404),
        );

        // act
        final call = dataSource.updateProduct(tUpdateProduct);

        // assert
        expect(() => call, throwsA(isA<BadRequestException>()));
      },
    );
  });

  group('Delete products', () {
    const tProductId = '66e17bbbfe837603e816b966';

    test(
      'Should return product response when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.delete(
            Uri.parse('${ProductUrls.product}/$tProductId'),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            '',
            HttpStatus.ok,
          ),
        );

        // act
        await dataSource.deleteProduct(tProductId);

        // assert
        expect(null, equals(null));
      },
    );

    test(
      'Should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.delete(
            Uri.parse('${ProductUrls.product}/$tProductId'),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response('{}', 404),
        );

        // act
        final call = dataSource.deleteProduct(tProductId);

        // assert
        expect(() => call, throwsA(isA<BadRequestException>()));
      },
    );
  });
}
