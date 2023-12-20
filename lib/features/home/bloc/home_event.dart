part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

//home initial event will be the first event that is fired 
// when the application starts. 
class HomeInitialEvent extends HomeEvent{}

class HomeProductWishlistButtonClicked extends HomeEvent{
  final ProductDataModel productDataModel ;
  HomeProductWishlistButtonClicked({required this.productDataModel});
  

}
class HomeProductCartButtonClicked extends HomeEvent{
final ProductDataModel productDataModel ;
  HomeProductCartButtonClicked({required this.productDataModel});
}
class HomeWishlistButtonNavigateEvent extends HomeEvent{

}
class HomeCartButtonNavigateEvent extends HomeEvent{
  
}

// first thing to fo when making a bloc is to think of 
// all the events that can take place;