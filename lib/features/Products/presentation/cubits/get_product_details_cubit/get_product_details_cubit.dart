// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meem/core/utils/models/product_model/product_model.dart';
import 'package:meem/features/home/data/repos/home_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'get_product_details_state.dart';

class GetProductDetailsCubit extends Cubit<GetProductDetailsState> {
  final HomeRepo homeRepo;

  GetProductDetailsCubit({required this.homeRepo})
      : super(GetProductDetailsInitial());

  void getProductDetails({required String id}) async {
    emit(GetProductDetailsLoading());
    var result = await homeRepo.getProductDetails(id: id);

    result.fold(
        (failure) =>
            emit(GetProductDetailsFail(errorMessage: failure.errorMessage)),
        (product) => emit(GetProductDetailsSuccess(product: product)));
  }
}
