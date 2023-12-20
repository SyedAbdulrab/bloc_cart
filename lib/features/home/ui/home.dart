import 'package:flutter/material.dart';
import 'package:tut_bloc/features/cart/ui/cart.dart';
import 'package:tut_bloc/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tut_bloc/features/home/ui/product_tile.dart';
import 'package:tut_bloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// now the UI should be listening to the events that the bloc is passing
// for that we need to wrap it with a BLOC consumer
// this will listen to the events and the states that are being emitted as well

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        // I only want to listen when I get an action state
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ));
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Wishlist();
              },
            ),
          );
        } else if (state is HomeProductItemAddedToCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Item added to Cart")));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Item added to Wishlist")));
        }
      },
      builder: (context, state) {
        // i conly want to build when I dont get an action state
        switch (state.runtimeType) {
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                title: const Text("AR's Grocery App"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag))
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) => ProductTile(
                  productDataModel: successState.products[index],
                  homeBloc: homeBloc,
                ),
              ),
            );
          case HomeLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case HomeErrorState:
            return const Center(
              child: Text("aww snap, sth went wrong"),
            );
          default:
            return const Placeholder();
        }
      },
    );
  }
}
