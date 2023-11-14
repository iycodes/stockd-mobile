part of 'hometab1_cubit.dart';

enum HomeTabStatus {
  initial,
  loading,
  loaded,
  error,
}

class Hometab1State extends Equatable {
  const Hometab1State({
    required this.status,
    this.data,
  });
  final HomeTabStatus status;
  final ItemList? data;

  static Hometab1State initial() {
    return const Hometab1State(status: HomeTabStatus.initial);
  }

  Hometab1State copyWith({
    HomeTabStatus? status,
    ItemList? data,
  }) {
    print("copyWith");
    return Hometab1State(
        status: status ?? this.status, data: data ?? this.data);
  }

  @override
  List<Object?> get props => [status, data];
}
