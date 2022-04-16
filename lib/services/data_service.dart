import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wolf_app/global/enviroment.dart';
import 'package:wolf_app/models/client_response.dart';
import 'package:wolf_app/models/cliente.dart';
import 'package:wolf_app/models/color.dart';
import 'package:wolf_app/models/color_response.dart';
import 'package:wolf_app/services/auth_service.dart';

class DataService with ChangeNotifier {
  List<Client> clientsList = [];
  List<ColorModel> colorsList = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> createClient(Client client) async {
    isLoading = true;

    final data = client.toJson();
    final token = await AuthService.getToken();

    final resp = await http.post(
        Uri.parse('${Enviroment.apiUrl}/register/cliente'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token ?? '',
        });

    isLoading = false;

    if (resp.statusCode == 200) {
      final client = Client.fromJson(json.decode(resp.body)['cliente']);
      clientsList.add(client);

      return {'ok': true, 'msg': 'Cliente creado correctamente'};
    } else {
      final result = json.decode(resp.body);
      return {'ok': false, 'msg': result['msg']};
    }
  }

  Future<Map<String, dynamic>> getClients() async {
    isLoading = true;

    try {
      final resp = await http
          .get(Uri.parse('${Enviroment.apiUrl}/data/clientes'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? '',
      });

      isLoading = false;

      if (resp.statusCode == 200) {
        final clientsResponse = clientResponseFromJson(resp.body);

        return {
          'ok': true,
          'msg': 'Se obtuvo los clientes',
          'clients': clientsResponse.clientes,
        };
      } else {
        final result = json.decode(resp.body);
        return {'ok': false, 'msg': result['msg']};
      }
    } catch (e) {
      isLoading = false;
      return {'ok': false, 'msg': e.toString()};
    }
  }

  Future<Map<String, dynamic>> createColor(String color) async {
    isLoading = true;

    final data = {"name_color": color};

    final resp = await http.post(
        Uri.parse('${Enviroment.apiUrl}/register/color'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? '',
        });

    isLoading = false;

    if (resp.statusCode == 200) {
      final color = ColorModel.fromJson(json.decode(resp.body)['color']);
      colorsList.add(color);

      return {'ok': true, 'msg': 'Color registrado correctamente'};
    } else {
      final result = json.decode(resp.body);
      return {'ok': false, 'msg': result['msg']};
    }
  }

  Future<Map<String, dynamic>> getColors() async {
    isLoading = true;

    try {
      final resp = await http
          .get(Uri.parse('${Enviroment.apiUrl}/data/colores'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? '',
      });

      isLoading = false;

      if (resp.statusCode == 200) {
        final colorsResponse = colorResponseFromJson(resp.body);

        return {
          'ok': true,
          'msg': 'Se obtuvo los clientes',
          'colors': colorsResponse.colors,
        };
      } else {
        final result = json.decode(resp.body);
        return {'ok': false, 'msg': result['msg']};
      }
    } catch (e) {
      isLoading = false;
      return {'ok': false, 'msg': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteColor(String id) async {
    isLoading = true;

    final data = {"_id": id};

    try {
      final resp = await http.delete(
          Uri.parse('${Enviroment.apiUrl}/delete/color'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken() ?? '',
          });

      isLoading = false;

      if (resp.statusCode == 200) {
        final result = json.decode(resp.body);
        return {
          'ok': true,
          'msg': result['msg'],
        };
      } else {
        final result = json.decode(resp.body);
        return {'ok': false, 'msg': result['msg']};
      }
    } catch (e) {
      isLoading = false;
      return {'ok': false, 'msg': e.toString()};
    }
  }
}
