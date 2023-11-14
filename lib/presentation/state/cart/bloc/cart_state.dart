part of 'cart_bloc.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState extends Equatable {
  final CartStatus status;
  final String? ownerId;
  final Cart? cart;
  const CartState({required this.status, this.ownerId, this.cart});

  static CartState initial() => const CartState(
        status: CartStatus.initial,
      );

  CartState copyWith({CartStatus? status, String? ownerId, Cart? cart}) =>
      CartState(
          status: status ?? this.status,
          ownerId: ownerId ?? this.ownerId,
          cart: cart ?? this.cart);

  @override
  List<Object?> get props => [status, ownerId, cart];
}
