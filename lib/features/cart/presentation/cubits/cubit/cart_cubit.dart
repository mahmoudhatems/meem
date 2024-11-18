// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meem/features/cart/data/models/cart_item/cart_item.dart';
import 'package:meem/features/cart/data/models/operation_cart_response.dart';
import 'package:meem/features/cart/data/repos/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {

  CartRepo cardRepo;
  CartCubit({required this.cardRepo}) : super(CartInitial());
  getCartProducts() async {
    emit(GetCartProductsLoading());
    var results = await cardRepo.getCartProducts();
    results.fold(
      (failure) =>
          emit(GetCartProductsFail(errorMessage: failure.errorMessage)),
      (products) => emit(GetCartProductsSuccess(products: products)),
    );
  }

  addOrRemoveFromCart({required String id}) async {
    emit(AddOrRemoveFromCartLoading());
    var results = await cardRepo.addOrRemoveFromCart(id: id);
    results.fold(
      (failure) =>
          emit(AddOrRemoveFromCartFail(errorMessage: failure.errorMessage)),
      (response) => emit(AddOrRemoveFromCartSuccess(response: response)),
    );
  }
}
