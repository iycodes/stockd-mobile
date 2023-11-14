import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stockd/common/models/api_response.dart';
import 'package:stockd/data/models/user/user.dart';
import 'package:stockd/domain/api_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final _apiRepo = ApiRepo();
  UserCubit() : super(UserState.initial());
  void initial() => emit(const UserState(status: userStatus.initial));
  void loginClicked() => emit(const UserState(status: userStatus.loggingIn));
  void loginSuccess(LoggedInUserModel user) {
    // print(user.email);
    emit(UserState(status: userStatus.loggedIn, loggedInUser: user));
  }

  void onLogin() => emit(const UserState(status: userStatus.loggingIn));
  void onLogout() => emit(const UserState(status: userStatus.loggingOut));

  Future<String> saveItem(List<String> data, String userId) async {
    // emit(state)
    final res = await _apiRepo.saveItem(data, userId);
    if (res.status == ApiReqStatus.success) {
      final deserializedData = LoggedInUserModel.fromJson(res.data);
      emit(const UserState(status: userStatus.loggedIn)
          .copyWith(loggedInUser: deserializedData));
      return "saved";
    } else {
      return "error";
    }
  }

  unSaveItem(List<String> data, String userId) async {
    final res = await _apiRepo.unSaveItem(data, userId);
    if (res.status == ApiReqStatus.success) {
      final deserializedData = LoggedInUserModel.fromJson(res.data);
      emit(const UserState(status: userStatus.loggedIn).copyWith(
          loggedInUser: deserializedData, updatedText: "item updated"));
    } else {}
  }
}
