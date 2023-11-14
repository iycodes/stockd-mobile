import 'package:stockd/common/models/api_response.dart';
import 'package:stockd/common/network/api_service.dart';
import 'package:stockd/data/models/item.dart';
import 'package:stockd/data/models/user/user.dart';

class ApiRepo {
  final _provider = ApiService();

  Future<ApiResponse> login(UserLoginModel data) async {
    final jsonData = data.toJson();
    print("data sent => $jsonData");
    final resJson = await _provider.postSingle("login", jsonData);
    return resJson;
  }

  Future<ApiResponse> fetchHomeTab1Items() async {
    final respJson = _provider.fetchSingle("homeTab1");
    return respJson;
  }

  Future<ApiResponse> fetchItem(String itemId) async {
    final res = await _provider.fetchSingle("item/$itemId");
    // final deserializedJson = Item.fromJson(res.data);
    // print(deserializedJson.description);
    return res;
  }

  Future<ApiResponse> fetchItems() async {
    final res = await _provider.fetchMultiple(
      "all_items",
    );
    // final deserializedJson = ItemList(res.data);
    // return [deserializedJson, res];
    return res;
  }

  Future<ApiResponse> fetchCart(String userId) async {
    final res = await _provider.fetchSingle("cart/$userId");
    return res;
  }

  Future<ApiResponse> postItem() async {
    final data = Item(
        id: "iyanufanoro@gmail.com-8",
        name: "namee",
        category: "FASHION",
        sellerId: "iyanufanoro@gmail.com",
        price: 50000,
        description: "description",
        gender: "MEN",
        thumbnail: "image",
        colors: [
          {
            "color": "#ffffff",
            "sizes": ["S-2", "XL-5", "XXL-3"]
          }
        ]).toJson();
    final res = await _provider.postSingle("add_item", data);
    return res;
  }

  // Future<ApiResponse> _addItem() async {
  // final res = await _provider.postSingle("add_item", item)
  // }
  Future<ApiResponse> saveItem(List<String> data, String userId) async {
    final res = await _provider.patch("$userId/savedItems/add", data);
    return res;
  }

  Future<ApiResponse> unSaveItem(List<String> data, String userId) async {
    final res = await _provider.patch("$userId/savedItems/remove", data);
    return res;
  }
}




// response = await Future.wait([dio.post('/info'), dio.get('/token')]); 