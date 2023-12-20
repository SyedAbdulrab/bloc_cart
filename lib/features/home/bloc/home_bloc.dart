import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tut_bloc/data/cart_items.dart';
import 'package:tut_bloc/data/grocery_data.dart';
import 'package:tut_bloc/data/wishlist_items.dart';
import 'package:tut_bloc/features/home/models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductWishlistButtonClicked>(homeProductWishlistButtonClicked);
    on<HomeProductCartButtonClicked>(homeProductCartButtonClicked);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((prod) => ProductDataModel(
                id: prod['id'],
                name: prod['name'],
                description: prod['description'],
                price: prod['price'],
                imageUrl: prod['imageUrl']))
            .toList()));
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("WishList in appbar clicked");
    emit(HomeNavigateToWishListPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Cart Clicked");
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonClicked(
      HomeProductWishlistButtonClicked event, Emitter<HomeState> emit) {
    print("WishList BUTTON clicked");
    print(event.productDataModel);
    wishlistItems.add(event.productDataModel);
    print(wishlistItems);
    emit(HomeProductItemWishlistedActionState());

  }

  FutureOr<void> homeProductCartButtonClicked(
      HomeProductCartButtonClicked event, Emitter<HomeState> emit) {
    print("CART button clicked");
    cartItems.add(event.productDataModel);
        emit(HomeProductItemAddedToCartActionState());

  }
}


// NOTES:-
// event -> bloc -> state
// whenever we want to do anthing n ui we pass an EVENT to the bloc
// and bloc takes that event uses its brain and does some logic
// and then it returns a state that is used by the UI