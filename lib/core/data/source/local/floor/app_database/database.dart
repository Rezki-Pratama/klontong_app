import 'dart:async';
import 'package:floor/floor.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:klontong_project/core/data/source/local/floor/dao/product_dao.dart';
import 'package:klontong_project/core/data/source/local/floor/enitities/product_entity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [ProductEntity])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
}
