import 'package:internet_connection_checker/internet_connection_checker.dart';
abstract class NetwokInfo {
  Future<bool> get isConnected;
}
class NetworkingInfoImpl implements NetwokInfo {
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkingInfoImpl(this._internetConnectionChecker);
  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}
