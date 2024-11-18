// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meem/core/utils/models/product_model/product_model.dart';
import 'package:meem/features/home/data/repos/home_repo.dart';

part 'get_searched_product_state.dart';

class GetSearchedProductCubit extends Cubit<GetSearchedProductState> {
  final TextEditingController searchController = TextEditingController();
  final HomeRepo homeRepo;
  GetSearchedProductCubit({required this.homeRepo})
      : super(GetSearchedProductInitial());

  void getSearchedProduct({required String searchedText}) async {
    emit(GetSearchedProductLoading());
    var results = await homeRepo.getSearchedProduct(searchedText: searchedText);
    results.fold((failure) {
      emit(GetSearchedProductFailure(errorMessage: failure.errorMessage));
    }, (products) {
      emit(GetSearchedProductSuccess(products: products));
    });
  }
}
