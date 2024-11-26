import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import '../../shared/models/product_model.dart';

class SembastDatabaseHelper {
  static const String dbName = 'products.db';
  static const String storeName = 'products';

  final _store = intMapStoreFactory.store(storeName);
  late Database _db;

  SembastDatabaseHelper() {
    _init();
  }

  Future<void> _init() async {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, dbName);
    _db = await databaseFactoryIo.openDatabase(dbPath);
  }

  Future<void> ensureInitialized() async {
    // ignore: unnecessary_null_comparison
    if (_db == null) {
      await _init();
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    await ensureInitialized();
    final records = await _store.find(_db);
    return records.map((snapshot) {
      final product = ProductModel.fromJson(snapshot.value);
      return product;
    }).toList();
  }

  Future<void> insertProduct(ProductModel product) async {
    await ensureInitialized();
    await _store.record(product.id!).put(_db, product.toJson());
  }

  Future<void> insertProducts(List<ProductModel> products) async {
    await ensureInitialized();
    final records = products.map((product) => MapEntry(product.id!, product.toJson())).toList();
    await _store.records(records.map((e) => e.key)).put(_db, records.map((e) => e.value).toList());
  }
}