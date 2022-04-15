import 'package:flutter/widgets.dart';
import 'package:wolf_app/pages/loading_page.dart';
import 'package:wolf_app/pages/login_page.dart';
import 'package:wolf_app/pages/register_page.dart';
import 'package:wolf_app/pages/usuarios_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios': (_) => const UsuariosPage(),
  'register': (_) => const RegisterPage(),
  'login': (_) => const LoginPage(),
  'loading': (_) => const LoadingPage()
};
