import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meem/core/errors/server_error.dart';
import 'package:meem/features/cart/data/data_sources/cart_data_source.dart';
import 'package:meem/features/cart/data/models/cart_item/cart_item.dart';
import 'package:meem/features/cart/data/models/operation_cart_response.dart';

abstract class CartRepo {
  Future<Either<Failure, List<CartItem>>> getCartProducts();

  Future<Either<Failure, OperationCartResponse>> addOrRemoveFromCart(
      {required String id});
}

class CartRepoImpl extends CartRepo {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepoImpl({required this.cartRemoteDataSource});

  @override
  Future<Either<Failure, List<CartItem>>> getCartProducts() async {
    try {
      List<CartItem> products =
          await cartRemoteDataSource.getCartProducts();

      return right(products);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OperationCartResponse>> addOrRemoveFromCart(
      {required String id}) async {
    try {
      OperationCartResponse cartResponse =
          await cartRemoteDataSource.addOrRemoveFromCart(id: id);

      return right(cartResponse);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
