// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meem/core/utils/models/product_model/product_model.dart';
import 'package:meem/features/home/data/repos/home_repo.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  final HomeRepo homeRepo;

  GetProductsCubit({required this.homeRepo}) : super(GetProductsInitial());

  Map<num, bool> favorites = {};
  void getProducts() async {
    emit(GetProductsLoading());
    var result = await homeRepo.getProducts();

    result.fold(
        (failure) => emit(GetProductsFail(errorMessage: failure.errorMessage)),
        (products) {
      for (var element in products) {
        favorites.addAll({element.id!: element.inFavorites!});
      }
      return emit(GetProductsSuccess(products: products));
    });
  }
}
