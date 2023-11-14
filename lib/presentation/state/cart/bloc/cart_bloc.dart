import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockd/data/models/cart/cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<FetchCartEvent>(_fetchCart);
    on<AddToCartEvent>(_addToCart);
    on<RemoveFromCartEvent>(_removeFromCart);
  }
  void _fetchCart(FetchCartEvent event, Emitter<CartState> emit) async {}
  void _addToCart(AddToCartEvent event, Emitter<CartState> emit) async {}
  void _removeFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {}
}
