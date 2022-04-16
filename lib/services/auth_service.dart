import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wolf_app/global/enviroment.dart';
import 'package:wolf_app/models/login_response.dart';
import 'package:wolf_app/models/user.dart';

class AuthService with ChangeNotifier {
  User? _user;
  bool _autenticando = false;

  final _storage = FlutterSecureStorage();

  User get user => _user!;

  bool get autenticando => _autenticando;
  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  Future<String?> getEmail() async {
    final _storage = FlutterSecureStorage();
    return await _storage.read(key: 'email');
  }

  Future<void> saveEmail(String email) async {
    final _storage = FlutterSecureStorage();
    await _storage.write(key: 'email', value: email);
  }

  Future<void> deleteEmail() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'email');
  }

  // Getter y setter del token
  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/login'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        });

    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      _user = loginResponse.user;

      await _guardarToken(loginResponse.token);

      return {
        'ok': true,
        'msg': 'Bienvenido',
      };
    } else {
      final result = jsonDecode(resp.body);
      return {
        'ok': false,
        'msg': result['msg'],
      };
    }
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    autenticando = true;

    final data = {'nombre': name, 'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/login/new'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        });

    autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      _user = loginResponse.user;

      await _guardarToken(loginResponse.token);

      return {"ok": true, "msg": "Usuario creado correctamente"};
    } else {
      print(resp.body);
      final result = json.decode(resp.body);
      return {"ok": false, "msg": result['msg']};
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();

    if (token != null) {
      final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/login/renew'),
          headers: {'x-token': token});

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        _user = loginResponse.user;
        await _guardarToken(loginResponse.token);
        return true;
      } else {
        logout();
        return false;
      }
    } else {
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
    _user = null;
  }
}
