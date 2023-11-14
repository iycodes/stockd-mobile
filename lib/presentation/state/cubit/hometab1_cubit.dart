import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stockd/common/models/api_response.dart';
import 'package:stockd/data/models/item.dart';
import 'package:stockd/domain/api_repo.dart';

part 'hometab1_state.dart';

class Hometab1Cubit extends Cubit<Hometab1State> {
  final _apiRepo = ApiRepo();
  Hometab1Cubit() : super(Hometab1State.initial());
  void onFetchHomeTabItems(List<String> savedItems) async {
    emit(const Hometab1State(status: HomeTabStatus.loading));
    await Future.delayed(const Duration(seconds: 3));
    ApiResponse res = await _apiRepo.fetchHomeTab1Items();
    if (res.status == ApiReqStatus.success) {
      ItemList deserializedJson = ItemList.fromJson(res.data);
      print(deserializedJson.items[0].isSaved);
      emit(const Hometab1State(status: HomeTabStatus.loaded)
          .copyWith(data: deserializedJson));
    }
  }

  void onItemsFetched(ItemList data) {
    emit(Hometab1State(status: HomeTabStatus.loaded, data: data));
  }

  void onErrorFetching() {
    // Future.delayed(const Duration(seconds: 1));
    emit(const Hometab1State(
      status: HomeTabStatus.error,
    ));
  }
}

// ItemList sortSaved(ItemList data, List<String> savedItems) {
//   final List<Item> items = data.items.map((e) {
//     if (savedItems.contains(e.id)) {
//       e.isSaved = true;
//       return e;
//     }
//     return e;
//   }).toList();
//   data.items = items;
//   return data;
// }
