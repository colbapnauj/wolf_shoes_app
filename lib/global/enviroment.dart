import 'dart:io';

class Enviroment {
  static String apiUrl =
      // Platform.isAndroid
      // ? 'http://10.0.2.2:3000/api'
      // : 'http://localhost:3000/api';
      'https://wolf-shoes-server.herokuapp.com/api';
  static String socketUrl = 'https://wolf-shoes-server.herokuapp.com/';
  // Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
