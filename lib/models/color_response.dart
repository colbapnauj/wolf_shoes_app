// To parse this JSON data, do
//
//     final colorResponse = colorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wolf_app/models/color.dart';

ColorResponse colorResponseFromJson(String str) =>
    ColorResponse.fromJson(json.decode(str));

String colorResponseToJson(ColorResponse data) => json.encode(data.toJson());

class ColorResponse {
  ColorResponse({
    required this.ok,
    required this.colors,
  });

  bool ok;
  List<ColorModel> colors;

  factory ColorResponse.fromJson(Map<String, dynamic> json) => ColorResponse(
        ok: json["ok"],
        colors: List<ColorModel>.from(
            json["colors"].map((x) => ColorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
      };
}
