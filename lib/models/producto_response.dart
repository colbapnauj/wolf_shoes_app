// To parse this JSON data, do
//
//     final productoResponse = productoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wolf_app/models/producto.dart';

ProductoResponse productoResponseFromJson(String str) =>
    ProductoResponse.fromJson(json.decode(str));

String productoResponseToJson(ProductoResponse data) =>
    json.encode(data.toJson());

class ProductoResponse {
  ProductoResponse({
    required this.ok,
    required this.producto,
  });

  bool ok;
  List<Producto> producto;

  factory ProductoResponse.fromJson(Map<String, dynamic> json) =>
      ProductoResponse(
        ok: json['ok'],
        producto: List<Producto>.from(
            json['producto'].map((x) => Producto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'ok': ok,
        'producto': List<dynamic>.from(producto.map((x) => x.toJson())),
      };
}
