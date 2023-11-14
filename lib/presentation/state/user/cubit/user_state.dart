part of 'user_cubit.dart';

enum userStatus {
  initial,
  loggedOut,
  loggingIn,
  loggedIn,
  loggingOut,
  error,
}

class UserState extends Equatable {
  final userStatus status;
  final UserLoginModel? loginDetails;
  final LoggedInUserModel? loggedInUser;
  final String? updatedText;
  final String? errorMessage;
  const UserState(
      {required this.status,
      this.loggedInUser,
      this.loginDetails,
      this.updatedText,
      this.errorMessage});
  static UserState initial() => const UserState(
        status: userStatus.initial,
      );
  UserState copyWith({
    userStatus? status,
    UserLoginModel? loginDetails,
    LoggedInUserModel? loggedInUser,
    String? updatedText,
    String? errorMessage,
  }) {
    print("updated=> $updatedText");
    return UserState(
        status: status ?? this.status,
        loggedInUser: loggedInUser ?? this.loggedInUser,
        loginDetails: loginDetails ?? this.loginDetails,
        updatedText: updatedText ?? this.updatedText,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [status, loginDetails, loggedInUser, updatedText, errorMessage];
}
