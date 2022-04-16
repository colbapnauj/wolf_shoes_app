// To parse this JSON data, do
//
//     final clientResponse = clientResponseFromJson(jsonString);

import 'dart:convert';

import 'package:wolf_app/models/cliente.dart';

ClientResponse clientResponseFromJson(String str) =>
    ClientResponse.fromJson(json.decode(str));

String clientResponseToJson(ClientResponse data) => json.encode(data.toJson());

class ClientResponse {
  ClientResponse({
    required this.ok,
    required this.clientes,
  });

  bool ok;
  List<Client> clientes;

  factory ClientResponse.fromJson(Map<String, dynamic> json) => ClientResponse(
        ok: json["ok"],
        clientes:
            List<Client>.from(json["clientes"].map((x) => Client.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "clientes": List<dynamic>.from(clientes.map((x) => x.toJson())),
      };
}
