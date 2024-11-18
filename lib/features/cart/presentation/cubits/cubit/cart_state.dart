// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

class CartState {}

class CartInitial extends CartState {}

class GetCartProductsLoading extends CartState {}

class GetCartProductsSuccess extends CartState {
  List<CartItem> products;
  GetCartProductsSuccess({
    required this.products,
  });
}

class GetCartProductsFail extends CartState {
  String errorMessage;
  GetCartProductsFail({
    required this.errorMessage,
  });
}

class AddOrRemoveFromCartLoading extends CartState {}

class AddOrRemoveFromCartSuccess extends CartState {
  OperationCartResponse response;
  AddOrRemoveFromCartSuccess({
    required this.response,
  });
}

class AddOrRemoveFromCartFail extends CartState {
  String errorMessage;
  AddOrRemoveFromCartFail({
    required this.errorMessage,
  });
}
