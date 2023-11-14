part of 'cart_cubit.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState extends Equatable {
  final CartStatus status;
  final String? ownerId;
  final Cart? data;
  const CartState({required this.status, this.ownerId, this.data});

  static CartState initial() => const CartState(
        status: CartStatus.initial,
      );

  CartState copyWith({CartStatus? status, String? ownerId, Cart? data}) =>
      CartState(
          status: status ?? this.status,
          ownerId: ownerId ?? this.ownerId,
          data: data ?? this.data);

  @override
  List<Object?> get props => [
        status,
        ownerId,
        data,
      ];
}
