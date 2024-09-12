import 'package:floor/floor.dart';
import 'package:klontong_project/core/data/source/local/floor/enitities/product_entity.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM ProductEntity')
  Future<List<ProductEntity>> findAllProduct();

  @Query('SELECT * FROM ProductEntity WHERE id = :id')
  Future<ProductEntity?> findProdudctById(int id);

  @insert
  Future<void> insertProdudct(ProductEntity data);

  @update
  Future<void> updateProdudct(ProductEntity data);

  @delete
  Future<void> deleteProdudct(ProductEntity data);
}
