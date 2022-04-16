class User {
  User({
    required this.nombre,
    required this.email,
    required this.uid,
  });

  String nombre;
  String email;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
        nombre: json['nombre'],
        email: json['email'],
        uid: json['uid'],
      );

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'email': email,
        'uid': uid,
      };
}
