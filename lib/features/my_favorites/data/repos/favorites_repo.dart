import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meem/core/errors/server_error.dart';
import 'package:meem/core/utils/models/product_model/product_model.dart';
import 'package:meem/features/my_favorites/data/data_sources/favorites_data_source.dart';
import 'package:meem/features/my_favorites/data/models/va/favorites_response_model.dart';
abstract class MyFavoritesRepo {
  Future<Either<Failure, List<ProductModel>>> getFavorites();
  Future<Either<Failure, FavoritesResponseModel>> changeFavorites(
      {required int id});
}

class MyFavoritesRepoImpl extends MyFavoritesRepo {
  final MyFavoritesDataSource favoritesDataSource;

  MyFavoritesRepoImpl({required this.favoritesDataSource});
  @override
  Future<Either<Failure, FavoritesResponseModel>> changeFavorites(
      {required int id}) async {
    try {
      FavoritesResponseModel favoritesResponse =
          await favoritesDataSource.changeFavorites(id: id);
      return right(favoritesResponse);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getFavorites() async {
    try {
      List<ProductModel> products = await favoritesDataSource.getFavorites();
      return right(products);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
