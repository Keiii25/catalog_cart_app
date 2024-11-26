import '../../../../core/drivers/api_helper.dart';
import '../../../../shared/models/product_model.dart';

class ProductRemoteDataSource {
  final ApiHelper apiHelper;

  ProductRemoteDataSource(this.apiHelper);


  Future<List<ProductModel>> fetchProducts({int page = 1}) async {
    final response = await apiHelper.getRequest('?page=$page',);

    return (response.data['products'] as List).map((json) => ProductModel.fromJson(json)).toList();
  }
}