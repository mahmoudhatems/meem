import 'package:meem/core/api/api_consumer.dart';
import 'package:meem/core/api/endpoints.dart';
import 'package:meem/core/utils/models/auth_model/auth_model.dart';
import 'package:meem/core/utils/models/auth_model/user_info_model.dart';
import 'package:meem/core/utils/models/product_model/product_model.dart';
import 'package:meem/features/home/data/models/category_model.dart';

abstract class HomeDataSource {
  Future<List<ProductModel>> getProducts();
  Future<UserInfoModel> getUserInfo();
  Future<AuthModel> updateUserInfo({
    required String name,
    required String email,
    required String phone,
  });
  Future<ProductModel> getProductDetails({required String id});
  Future<List<ProductModel>> getSearchedProduct({required String searchedText});
  Future<List<ProductModel>> getCategoriesProduct({required String id});
  Future<List<CategoryModel>> getCategories();
}

class HomeDataSourceImpl extends HomeDataSource {
  final ApiConsumer apiConsumer;

  HomeDataSourceImpl({required this.apiConsumer});
  @override
  Future<List<ProductModel>> getProducts() async {
    Map<String, dynamic> jsonData =
        await apiConsumer.get(endPoint: EndPoints.home);
    List<dynamic> results = jsonData["data"]["products"];
    List<ProductModel> products = [];
    for (var productData in results) {
      products.add(ProductModel.fromJson(productData));
    }
    return products;
  }

  @override
  Future<UserInfoModel> getUserInfo() async {
    Map<String, dynamic> jsonData =
        await apiConsumer.get(endPoint: EndPoints.profile);
    return UserInfoModel.fromJson(jsonData["data"]);
  }

  @override
  Future<ProductModel> getProductDetails({required String id}) async {
    Map<String, dynamic> jsonData = await apiConsumer.get(
      endPoint: "${EndPoints.products}/$id",
    );
    return ProductModel.fromJson(jsonData["data"]);
  }

  @override
  Future<List<ProductModel>> getSearchedProduct(
      {required String searchedText}) async {
    Map<String, dynamic> jsonData = await apiConsumer
        .post(endPoint: EndPoints.search, bodyData: {"text": searchedText});
    List<dynamic> results = jsonData["data"]["data"];
    List<ProductModel> searchedProducts = [];
    for (var productData in results) {
      searchedProducts.add(ProductModel.fromJson(productData));
    }
    return searchedProducts;
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    Map<String, dynamic> jsonData =
        await apiConsumer.get(endPoint: EndPoints.categories);
    List<dynamic> results = jsonData["data"]["data"];
    List<CategoryModel> categories = [];
    for (var productData in results) {
      categories.add(CategoryModel.fromJson(productData));
    }

    return categories;
  }

  @override
  Future<List<ProductModel>> getCategoriesProduct({required String id}) async {
    Map<String, dynamic> jsonData =
        await apiConsumer.get(endPoint: "${EndPoints.categories}/$id");
    List<dynamic> results = jsonData["data"]["data"];
    List<ProductModel> products = [];
    for (var productData in results) {
      products.add(ProductModel.fromJson(productData));
    }

    return products;
  }

  @override
  Future<AuthModel> updateUserInfo({
    required String name,
    required String email,
    required String phone,
  }) async {
    Map<String, dynamic> jsonData =
        await apiConsumer.put(endPoint: EndPoints.updateProfile, bodyData: {
      "name": name,
      "email": email,
      "phone": phone,
    });
    return AuthModel.fromJson(jsonData["data"]);
  }
}
