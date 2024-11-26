import '../../../../shared/models/product_model.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductModel>> execute({int page = 1}) {
    return repository.getProducts(page: page);
  }
}