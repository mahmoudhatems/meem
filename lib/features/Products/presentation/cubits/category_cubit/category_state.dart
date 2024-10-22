part of 'category_cubit.dart';

class CategoryState {}

final class GetCategoryInitial extends CategoryState {}

final class GetCategoryLoading extends CategoryState {}

final class GetCategorySuccess extends CategoryState {
  List<CategoryModel> categories;
  GetCategorySuccess({required this.categories});
}

final class GetCategoryFail extends CategoryState {
  final String errorMessage;
  GetCategoryFail({required this.errorMessage});
}

final class GetCategoryProductsInitial extends CategoryState {}

final class GetCategoryProductsLoading extends CategoryState {}

final class GetCategoryProductsSuccess extends CategoryState {
  List<ProductModel> products;
  GetCategoryProductsSuccess({required this.products});
}

final class GetCategoryProductsFail extends CategoryState {
  final String errorMessage;
  GetCategoryProductsFail({required this.errorMessage});
}
