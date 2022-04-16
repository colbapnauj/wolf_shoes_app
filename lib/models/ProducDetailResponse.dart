// To parse this JSON data, do
//
//     final productDetailResponse = productDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wolf_app/models/color.dart';
import 'package:wolf_app/models/talla.dart';
import 'package:wolf_app/models/zapato.dart';

ProductDetailResponse productDetailResponseFromJson(String str) =>
    ProductDetailResponse.fromJson(json.decode(str));

String productDetailResponseToJson(ProductDetailResponse data) =>
    json.encode(data.toJson());

class ProductDetailResponse {
  ProductDetailResponse({
    required this.ok,
    required this.productos,
  });

  bool ok;
  List<ProductDetail> productos;

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponse(
        ok: json['ok'],
        productos: List<ProductDetail>.from(
            json['productos'].map((x) => ProductDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'ok': ok,
        'productos': List<dynamic>.from(productos.map((x) => x.toJson())),
      };
}

class ProductDetail {
  ProductDetail({
    required this.modelo,
    required this.color,
    required this.talla,
    required this.cantidad,
    required this.precio,
  });

  Zapato modelo;
  ColorModel color;
  Talla talla;
  String cantidad;
  String precio;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        modelo: Zapato.fromJson(json['modelo']),
        color: ColorModel.fromJson(json['color']),
        talla: Talla.fromJson(json['talla']),
        cantidad: json['cantidad'],
        precio: json['precio'],
      );

  Map<String, dynamic> toJson() => {
        'modelo': modelo.toJson(),
        'color': color.toJson(),
        'talla': talla.toJson(),
        'cantidad': cantidad,
        'precio': precio,
      };
}
