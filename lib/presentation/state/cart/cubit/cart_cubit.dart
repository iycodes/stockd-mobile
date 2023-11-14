import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockd/common/models/api_response.dart';
import 'package:stockd/data/models/cart/cart.dart';
import 'package:stockd/domain/api_repo.dart';
import 'package:stockd/presentation/state/cart/bloc/cart_bloc.dart';
part "cart_state.dart";

//
class CartCubit extends Cubit<CartState> {
  final _apiRepo = ApiRepo();
  CartCubit() : super(CartState.initial());

  _fetchCart(String userId) async {
    int retryCount = 0;
    final res = await _apiRepo.fetchCart(userId);
    if (res.status == ApiReqStatus.success) {
      final deserializedData = Cart.fromJson(res.data);
      emit(CartState(status: CartStatus.loaded, data: deserializedData));
    } else if (retryCount < 3) {
      retryCount++;
      _fetchCart(userId);
    } else {
      emit(const CartState(status: CartStatus.error).copyWith());
    }
  }

  _updateCart(Cart data) async {
    emit(const CartState(status: CartStatus.loading).copyWith());
    int retryCount = 0;
    final serializedData = data.toJson();
    final res = await _apiRepo.updateCart(serializedData);
    if (res.status == ApiReqStatus.success) {
      final deserializedData = Cart.fromJson(res.data);
      emit(CartState(status: CartStatus.loaded, data: deserializedData));
    } else if (retryCount < 3) {
      retryCount++;
      _updateCart(data);
    } else {
      emit(const CartState(status: CartStatus.error).copyWith());
    }
  }
}
