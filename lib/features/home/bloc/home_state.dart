part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

// one state can be the one that will  build my UI, this will be done by the HOME satte//
final class HomeInitial extends HomeState {}

// HOME UI STATES
class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;
  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

// HOME ACTION STATES

class HomeNavigateToWishListPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}


class HomeProductItemWishlistedActionState extends HomeActionState{}
class HomeProductItemAddedToCartActionState extends HomeActionState{}




// Ok so after the events have been though out we now move on to brainstorming
// all the states that xan be emitted out of the bloc


// there are 2 kinds of states, simple states and ACTIONALBE states