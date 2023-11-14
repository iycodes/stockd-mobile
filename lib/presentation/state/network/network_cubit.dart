import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkInfoCubit extends Cubit<ConnectivityResult> {
 void connectionChanged(ConnectivityResult result) {
    emit(result);
  }

  NetworkInfoCubit(Connectivity _connectivityService)
      : super((ConnectivityResult.wifi)) {
    _connectivityService.onConnectivityChanged.listen((event) {
      connectionChanged(event);
    });
  }
}

bool isConnected(ConnectivityResult connection) =>
    connection != ConnectivityResult.none;
