import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_remote_data_source.dart';
import '../../../../shared/models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductModel>> getProducts({int page = 1}) {
    return remoteDataSource.fetchProducts(page: page);
  }
}