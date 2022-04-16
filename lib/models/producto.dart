class Producto {
  Producto({
    required this.idModelo,
    required this.idTalla,
    required this.idColor,
    required this.cantidad,
    required this.precio,
    required this.uid,
  });

  String idModelo;
  String idTalla;
  String idColor;
  String cantidad;
  String precio;
  String uid;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idModelo: json['id_modelo'],
        idTalla: json['id_talla'],
        idColor: json['id_color'],
        cantidad: json['cantidad'],
        precio: json['precio'],
        uid: json['uid'],
      );

  Map<String, dynamic> toJson() => {
        'id_modelo': idModelo,
        'id_talla': idTalla,
        'id_color': idColor,
        'cantidad': cantidad,
        'precio': precio,
        'uid': uid,
      };
}
