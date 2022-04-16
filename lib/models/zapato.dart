import 'package:wolf_app/models/dropdown_item_model.dart';

class Zapato extends GlobalModel {
  Zapato({
    required this.nombreModelo,
    required this.uid,
  });

  String nombreModelo;
  String uid;

  factory Zapato.fromJson(Map<String, dynamic> json) => Zapato(
        nombreModelo: json['nombre_modelo'],
        uid: json['uid'],
      );

  Map<String, dynamic> toJson() => {
        'nombre_modelo': nombreModelo,
        'uid': uid,
      };

  @override
  String getId() {
    return uid;
  }

  @override
  String getValue() {
    return nombreModelo;
  }
}
