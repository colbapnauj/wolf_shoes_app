import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wolf_app/controller/global_controller.dart';
import 'package:wolf_app/global/enviroment.dart';
import 'package:wolf_app/models/ProducDetailResponse.dart';
import 'package:wolf_app/models/client_response.dart';
import 'package:wolf_app/models/cliente.dart';
import 'package:wolf_app/models/color.dart';
import 'package:wolf_app/models/color_response.dart';
import 'package:wolf_app/models/producto.dart';
import 'package:wolf_app/models/talla.dart';
import 'package:wolf_app/models/talla_response.dart';
import 'package:wolf_app/models/zapato.dart';
import 'package:wolf_app/models/zapato_response.dart';
import 'package:wolf_app/services/auth_service.dart';

class DataService with ChangeNotifier {
  List<Client> clientsList = [];
  List<ColorModel> colorsList = [];
  List<Talla> tallasList = [];
  List<Zapato> zapatosList = [];

  GlobalController gCtrl = GlobalController();

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

  Future<Map<String, dynamic>> createTalla(String talla) async {
    isLoading = true;

    final data = {"nro_talla": talla};

    final resp = await http.post(
        Uri.parse('${Enviroment.apiUrl}/register/talla'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? '',
        });

    isLoading = false;

    if (resp.statusCode == 200) {
      final talla = Talla.fromJson(json.decode(resp.body)['talla']);
      tallasList.add(talla);

      return {'ok': true, 'msg': 'Talla registrada correctamente'};
    } else {
      final result = json.decode(resp.body);
      return {'ok': false, 'msg': result['msg']};
    }
  }

  Future<Map<String, dynamic>> getTallas() async {
    isLoading = true;

    try {
      final resp = await http
          .get(Uri.parse('${Enviroment.apiUrl}/data/tallas'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? '',
      });

      isLoading = false;

      if (resp.statusCode == 200) {
        final tallasResponse = tallaResponseFromJson(resp.body);

        return {
          'ok': true,
          'msg': 'Se obtuvo las tallas',
          'tallas': tallasResponse.tallas,
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

  Future<Map<String, dynamic>> deleteTalla(String id) async {
    isLoading = true;

    final data = {"_id": id};

    try {
      final resp = await http.delete(
          Uri.parse('${Enviroment.apiUrl}/delete/talla'),
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

  Future<Map<String, dynamic>> createModelo(String modelo) async {
    isLoading = true;

    final data = {"nombre_modelo": modelo};

    final resp = await http.post(
        Uri.parse('${Enviroment.apiUrl}/register/zapato'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? '',
        });

    isLoading = false;

    if (resp.statusCode == 200) {
      final zapato = Zapato.fromJson(json.decode(resp.body)['zapato']);
      zapatosList.add(zapato);

      return {'ok': true, 'msg': 'Talla registrada correctamente'};
    } else {
      final result = json.decode(resp.body);
      return {'ok': false, 'msg': result['msg']};
    }
  }

  Future<Map<String, dynamic>> getModelosZapatos() async {
    isLoading = true;

    try {
      final resp = await http
          .get(Uri.parse('${Enviroment.apiUrl}/data/zapatos'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? '',
      });

      isLoading = false;

      if (resp.statusCode == 200) {
        final zapatosResponse = zapatoResponseFromJson(resp.body);

        return {
          'ok': true,
          'msg': 'Se obtuvo los modelos de zapatos',
          'zapatos': zapatosResponse.zapatos,
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

  Future<Map<String, dynamic>> deleteModeloZapato(String id) async {
    isLoading = true;

    final data = {"_id": id};

    try {
      final resp = await http.delete(
          Uri.parse('${Enviroment.apiUrl}/delete/zapato'),
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

  Future<Map<String, dynamic>> createProduct(Producto product) async {
    isLoading = true;

    final data = product.toJson();

    final resp = await http.post(
        Uri.parse('${Enviroment.apiUrl}/register/producto'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken() ?? '',
        });

    isLoading = false;

    if (resp.statusCode == 200) {
      final product = Producto.fromJson(json.decode(resp.body)['producto']);
      gCtrl.productsList.add(product);

      return {'ok': true, 'msg': 'Producto creado correctamente'};
    } else {
      final result = json.decode(resp.body);
      return {'ok': false, 'msg': result['msg']};
    }
  }

  Future<Map<String, dynamic>> getProductos() async {
    isLoading = true;

    try {
      final resp = await http
          .get(Uri.parse('${Enviroment.apiUrl}/data/productos'), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? '',
      });

      isLoading = false;

      if (resp.statusCode == 200) {
        final productsResponse = productDetailResponseFromJson(resp.body);

        return {
          'ok': true,
          'msg': 'Se obtuvo los productos',
          'clients': productsResponse.productos,
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
