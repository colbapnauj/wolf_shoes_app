import 'package:wolf_app/models/dropdown_item_model.dart';

class Talla extends GlobalModel {
  Talla({
    required this.talla,
    required this.uid,
  });

  String talla;
  String uid;

  factory Talla.fromJson(Map<String, dynamic> json) => Talla(
        talla: json['nro_talla'],
        uid: json['uid'],
      );

  Map<String, dynamic> toJson() => {
        'talla': talla,
        'uid': uid,
      };

  @override
  String getId() {
    return uid;
  }

  @override
  String getValue() {
    return talla;
  }
}
