import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stockd/common/models/api_response.dart';
import 'package:stockd/data/models/item.dart';
import 'package:stockd/domain/api_repo.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final _apiRepo = ApiRepo();
  ItemCubit() : super(ItemState.initial());
  fetchItem(String itemId) async {
    emit(ItemState(status: EventStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    final res = await _apiRepo.fetchItem(itemId);
    print(res);
    if (res.status == ApiReqStatus.success) {
      final data = Item.fromJson(res.data);
      emit(ItemState(status: EventStatus.loaded).copyWith(data: data));
    }
  }
}
