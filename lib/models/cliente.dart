class Client {
  Client({
    required this.dni,
    required this.nombre,
    required this.aPaterno,
    required this.aMaterno,
    required this.telefono,
    required this.direccion,
  });

  String dni;
  String nombre;
  String aPaterno;
  String aMaterno;
  String telefono;
  String direccion;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        dni: json['dni'],
        nombre: json['nombre'],
        aPaterno: json['apellidoPaterno'],
        aMaterno: json['apellidoMaterno'],
        telefono: json['telefono'],
        direccion: json['direccion'],
      );

  Map<String, dynamic> toJson() => {
        'dni': dni,
        'nombre': nombre,
        'apellidoPaterno': aPaterno,
        'apellidoMaterno': aMaterno,
        'telefono': telefono,
        'direccion': direccion,
      };
}
