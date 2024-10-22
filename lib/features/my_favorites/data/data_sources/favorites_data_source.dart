import 'package:meem/core/api/api_consumer.dart';
import 'package:meem/core/api/endpoints.dart';
import 'package:meem/core/utils/models/product_model/product_model.dart';
import 'package:meem/features/my_favorites/data/models/va/favorites_response_model.dart';

abstract class MyFavoritesDataSource {
  Future<List<ProductModel>> getFavorites();
  Future<FavoritesResponseModel> changeFavorites({required int id});
}

class MyFavoritesDataSourceImpl implements MyFavoritesDataSource {
  final ApiConsumer apiConsumer;

  MyFavoritesDataSourceImpl({required this.apiConsumer});
  @override
  Future<FavoritesResponseModel> changeFavorites({required int id}) async {
    Map<String, dynamic> jsonData = await apiConsumer
        .post(endPoint: EndPoints.favorites, isFormData: true, bodyData: {
      'product_id': id,
    });
    return FavoritesResponseModel.fromJson(jsonData);
  }

  @override
  Future<List<ProductModel>> getFavorites() async {
    Map<String, dynamic> jsonData = await apiConsumer.get(
      endPoint: EndPoints.favorites,
    );

    List<dynamic> results = jsonData["data"]["data"]['product'];
    List<ProductModel> products = [];
    for (var product in results) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }
}
