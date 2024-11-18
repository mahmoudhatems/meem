part of 'change_favorites_cubit.dart';

@immutable
sealed class ChangeFavoritesState {}

final class ChangeFavoritesInitial extends ChangeFavoritesState {}

final class ChangeFavoritesSuccess extends ChangeFavoritesState {
  final String message;

  ChangeFavoritesSuccess({required this.message});
}

final class ChangeFavoritesFail extends ChangeFavoritesState {
  final String errorMessage;
  ChangeFavoritesFail({required this.errorMessage});
}
