part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartEvent {
  final String userId;
  const FetchCartEvent(this.userId);
  @override
  List<Object> get props => [userId];
}

class AddToCartEvent extends CartEvent {
  final String itemId;
  const AddToCartEvent(this.itemId);
  @override
  List<Object> get props => [itemId];
}

class RemoveFromCartEvent extends CartEvent {
  final String itemId;
  const RemoveFromCartEvent(this.itemId);
  @override
  List<Object> get props => [itemId];
}
