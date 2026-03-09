import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenService {
  final FlutterSecureStorage storage;

  TokenService(this.storage);

  Future<void> saveToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }
}
