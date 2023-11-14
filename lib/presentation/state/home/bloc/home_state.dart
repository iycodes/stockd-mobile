part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,
  partiallyLoaded,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;

  const HomeState({required this.status});

  static HomeState initial() => const HomeState(
        status: HomeStatus.initial,
      );

  HomeState copyWith({
    HomeStatus? status,
  }) =>
      HomeState(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        status,
      ];
}
