import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:klontong_project/core/data/source/response/product_response.dart';

import '../../../json_reader.dart';

void main() {
  const product = [
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

  var productsWithNoData = const [];

  var productsWithNullCategory = const [
    ProductResponse(
      id: '66e17bbbfe837603e816b966',
      categoryId: 0,
      categoryName: '',
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

  group('From json', () {
    test(
      'Should return a valid products array with category cemilan',
      () async {
        // arrange
        final List<dynamic> jsonMap = json.decode(
          readJson('dummy_data/products/dummy_products_response.json'),
        );

        // act
        final result = List<ProductResponse>.from(
          jsonMap.map<ProductResponse>(
            (dynamic i) => ProductResponse.fromJson(i),
          ),
        );

        // assert
        expect(result, equals(product));
      },
    );
    test(
      'Should return a valid products array with no data found',
      () async {
        // arrange
        final List<dynamic> jsonMap = json.decode(
          readJson('dummy_data/products/dummy_products_no_data_response.json'),
        );

        // act
        final result = List<ProductResponse>.from(
          jsonMap.map<ProductResponse>(
            (dynamic i) => ProductResponse.fromJson(i),
          ),
        );

        // assert
        expect(result, equals(productsWithNoData));
      },
    );
    test(
      'Should return a valid products array with null category value',
      () async {
        // arrange
        final List<dynamic> jsonMap = json.decode(
          readJson(
              'dummy_data/products/dummy_products_no_category_response.json'),
        );

        // act
        final result = List<ProductResponse>.from(
          jsonMap.map<ProductResponse>(
            (dynamic i) => ProductResponse.fromJson(i),
          ),
        );

        // assert
        expect(result, equals(productsWithNullCategory));
      },
    );
  });
}
