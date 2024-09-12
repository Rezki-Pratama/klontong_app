// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `description` TEXT, `isActive` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productEntityInsertionAdapter = InsertionAdapter(
            database,
            'ProductEntity',
            (ProductEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'isActive':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0)
                }),
        _productEntityUpdateAdapter = UpdateAdapter(
            database,
            'ProductEntity',
            ['id'],
            (ProductEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'isActive':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0)
                }),
        _productEntityDeletionAdapter = DeletionAdapter(
            database,
            'ProductEntity',
            ['id'],
            (ProductEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'isActive':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductEntity> _productEntityInsertionAdapter;

  final UpdateAdapter<ProductEntity> _productEntityUpdateAdapter;

  final DeletionAdapter<ProductEntity> _productEntityDeletionAdapter;

  @override
  Future<List<ProductEntity>> findAllProduct() async {
    return _queryAdapter.queryList('SELECT * FROM ProductEntity',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            isActive: row['isActive'] == null
                ? null
                : (row['isActive'] as int) != 0));
  }

  @override
  Future<ProductEntity?> findProdudctById(int id) async {
    return _queryAdapter.query('SELECT * FROM ProductEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as int?,
            name: row['name'] as String?,
            description: row['description'] as String?,
            isActive:
                row['isActive'] == null ? null : (row['isActive'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> insertProdudct(ProductEntity data) async {
    await _productEntityInsertionAdapter.insert(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProdudct(ProductEntity data) async {
    await _productEntityUpdateAdapter.update(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProdudct(ProductEntity data) async {
    await _productEntityDeletionAdapter.delete(data);
  }
}
