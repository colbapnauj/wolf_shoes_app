// To parse this JSON data, do
//
//     final tallaResponse = tallaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wolf_app/models/talla.dart';

TallaResponse tallaResponseFromJson(String str) =>
    TallaResponse.fromJson(json.decode(str));

String tallaResponseToJson(TallaResponse data) => json.encode(data.toJson());

class TallaResponse {
  TallaResponse({
    required this.ok,
    required this.tallas,
  });

  bool ok;
  List<Talla> tallas;

  factory TallaResponse.fromJson(Map<String, dynamic> json) => TallaResponse(
        ok: json['ok'],
        tallas: List<Talla>.from(json['tallas'].map((x) => Talla.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'ok': ok,
        'tallas': List<dynamic>.from(tallas.map((x) => x.toJson())),
      };
}
