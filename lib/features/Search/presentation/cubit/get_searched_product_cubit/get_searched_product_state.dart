part of 'get_searched_product_cubit.dart';

@immutable
sealed class GetSearchedProductState {}

final class GetSearchedProductInitial extends GetSearchedProductState {}

final class GetSearchedProductLoading extends GetSearchedProductState {}

final class GetSearchedProductSuccess extends GetSearchedProductState {
  final List<ProductModel> products;
  GetSearchedProductSuccess({required this.products});
}

final class GetSearchedProductFailure extends GetSearchedProductState {
  final String errorMessage;
  GetSearchedProductFailure({required this.errorMessage});
}
