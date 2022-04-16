// To parse this JSON data, do
//
//     final zapatoResponse = zapatoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wolf_app/models/zapato.dart';

ZapatoResponse zapatoResponseFromJson(String str) =>
    ZapatoResponse.fromJson(json.decode(str));

String zapatoResponseToJson(ZapatoResponse data) => json.encode(data.toJson());

class ZapatoResponse {
  ZapatoResponse({
    required this.ok,
    required this.zapatos,
  });

  bool ok;
  List<Zapato> zapatos;

  factory ZapatoResponse.fromJson(Map<String, dynamic> json) => ZapatoResponse(
        ok: json['ok'],
        zapatos:
            List<Zapato>.from(json['zapatos'].map((x) => Zapato.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'ok': ok,
        'zapatos': List<dynamic>.from(zapatos.map((x) => x.toJson())),
      };
}
