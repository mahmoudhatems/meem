part of 'get_product_details_cubit.dart';

@immutable
sealed class GetProductDetailsState {}

final class GetProductDetailsInitial extends GetProductDetailsState {}

final class GetProductDetailsLoading extends GetProductDetailsState {}

final class GetProductDetailsSuccess extends GetProductDetailsState {
  final ProductModel product;

  GetProductDetailsSuccess({required this.product});
}

final class GetProductDetailsFail extends GetProductDetailsState {
  final String errorMessage;

  GetProductDetailsFail({required this.errorMessage});
}
