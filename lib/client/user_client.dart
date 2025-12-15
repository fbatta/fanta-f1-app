import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class UserClient {
  final _getIt = GetIt.instance;
  late final Dio _dio;

  UserClient() {
    _dio = _getIt<Dio>();
  }

  Future<void> requestCreateUserInfo(String uid, String displayName) async {
    final response = _dio.post('/userinfo/create', data: {
      'uid': uid,
      'displayName': displayName,
    });
  }
}