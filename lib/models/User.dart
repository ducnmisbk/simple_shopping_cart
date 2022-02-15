import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User with ChangeNotifier {
  String? _username = '';
  String? _password = '';
  bool isLoading = false;

  static const FS_USERNAME = '12j1kj2kj1k2';
  static const FS_PASSWORD = 'kljlk12312kj';

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      return false;
    }
    isLoading = true;
    return Future.delayed(const Duration(seconds: 5), () {
      _username = username;
      _password = password;
      notifyListeners();
      isLoading = false;

      const _storage = FlutterSecureStorage();
      _storage.write(key: FS_USERNAME, value: _username);
      _storage.write(key: FS_PASSWORD, value: _password);

      return true;
    });
  }

  Future<bool> reLogin() async {
    const _storage = FlutterSecureStorage();
    _username = await _storage.read(key: FS_USERNAME);
    _password = await _storage.read(key: FS_PASSWORD);

    return Future.delayed(const Duration(seconds: 5), () {
      if (_username == null || _password == null) {
        return false;
      } else {
        return true;
      }
    });
  }

  void logout() {
    _username = '';
    _password = '';
    notifyListeners();

    const _storage = FlutterSecureStorage();
    _storage.delete(key: FS_USERNAME);
    _storage.delete(key: FS_PASSWORD);
  }
}
