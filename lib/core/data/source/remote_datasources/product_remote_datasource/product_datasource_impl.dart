import 'package:klontong_project/core/data/exception.dart';
import 'package:klontong_project/core/data/source/remote/api_base_helper.dart';
import 'package:klontong_project/core/data/source/remote_datasources/product_remote_datasource/product_datasource.dart';
import 'package:klontong_project/core/data/source/remote_datasources/product_remote_datasource/product_urls.dart';
import 'package:klontong_project/core/data/source/response/product_response.dart';
import 'package:klontong_project/core/domains/model/product.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiBaseHelper apiBaseHelper;

  ProductRemoteDataSourceImpl({required this.apiBaseHelper});

  @override
  Future<List<ProductResponse>> retrieveProduct(
      {int page = 1, String search = ''}) async {
    int limit = 10;
    final response = await apiBaseHelper.getPublicApi(ProductUrls.product);

    try {
      // Convert the response to a list of ProductResponse
      final allProducts = List<ProductResponse>.from(
        response.map<ProductResponse>(
          (dynamic i) => ProductResponse.fromJson(i),
        ),
      );

      // Apply search filter if search is not empty
      final filteredProducts = search.isEmpty
          ? allProducts
          : allProducts
              .where((product) =>
                  product.name.toLowerCase().contains(search.toLowerCase()))
              .toList();

      // Calculate start and end index for pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;

      // Check if startIndex is within bounds
      if (startIndex >= filteredProducts.length || startIndex < 0) {
        // Return an empty list if the page is out of range
        return [];
      }

      // Slice the dataset to return the desired page
      final paginatedProducts = filteredProducts.sublist(
        startIndex,
        endIndex > filteredProducts.length ? filteredProducts.length : endIndex,
      );

      return paginatedProducts;
    } catch (e) {
      throw ParseDataException();
    }
  }

  @override
  Future<ProductResponse> storeProduct(Product data) async {
    final response = await apiBaseHelper.postPublicApi(
      ProductUrls.product,
      body: {
        'CategoryId': data.categoryId,
        'categoryName': data.categoryName,
        'sku': data.sku,
        'name': data.name,
        'description': data.description,
        'weight': data.weight,
        'width': data.width,
        'length': data.length,
        'height': data.height,
        'image': data.image,
        'harga': data.price,
      },
    );
    try {
      return ProductResponse.fromJson(response);
    } catch (e) {
      throw ParseDataException();
    }
  }

  @override
  Future<void> updateProduct(Product data) async {
    await apiBaseHelper.updatePublicApi(
      '${ProductUrls.product}/${data.id}',
      body: {
        'CategoryId': data.categoryId,
        'categoryName': data.categoryName,
        'sku': data.sku,
        'name': data.name,
        'description': data.description,
        'weight': data.weight,
        'width': data.width,
        'length': data.length,
        'height': data.height,
        'image': data.image,
        'harga': data.price,
      },
    );
    try {
      return;
    } catch (e) {
      throw ParseDataException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    await apiBaseHelper.deletePublicApi(
      '${ProductUrls.product}/$id',
    );
    try {
      return;
    } catch (e) {
      throw ParseDataException();
    }
  }
}
