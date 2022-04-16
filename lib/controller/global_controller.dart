import 'package:wolf_app/models/producto.dart';

class GlobalController {
  // Singleton
  factory GlobalController() => _instance;
  GlobalController._internal();
  static final GlobalController _instance = GlobalController._internal();

  List<Producto> productsList = [];
}
