// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meem/core/utils/models/product_model/product_model.dart';
import 'package:meem/features/home/data/models/category_model.dart';
import 'package:meem/features/home/data/repos/home_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  HomeRepo homeRepo;
  CategoryCubit({required this.homeRepo}) : super(GetCategoryInitial());
  getCategory() async {
    emit(GetCategoryLoading());
    var results = await homeRepo.getCategories();
    results.fold(
        (failure) => emit(GetCategoryFail(errorMessage: failure.errorMessage)),
        (categories) => emit(GetCategorySuccess(categories: categories)));
  }

  getCategoryProducts({required String id}) async {
    emit(GetCategoryProductsLoading());
    var results = await homeRepo.getCategoriesProduct(id: id);
    results.fold(
        (failure) =>
            emit(GetCategoryProductsFail(errorMessage: failure.errorMessage)),
        (products) => emit(GetCategoryProductsSuccess(products: products)));
  }
}
