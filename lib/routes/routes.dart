import 'package:flutter/widgets.dart';
import 'package:wolf_app/pages/clients_page.dart';
import 'package:wolf_app/pages/colors_page.dart';
import 'package:wolf_app/pages/home_page.dart';
import 'package:wolf_app/pages/loading_page.dart';
import 'package:wolf_app/pages/login_page.dart';
import 'package:wolf_app/pages/register_client.dart';
import 'package:wolf_app/pages/register_color.dart';
import 'package:wolf_app/pages/register_page.dart';
import 'package:wolf_app/pages/usuarios_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios': (_) => const UsuariosPage(),
  'register': (_) => const RegisterPage(),
  'login': (_) => const LoginPage(),
  'loading': (_) => const LoadingPage(),
  'home': (_) => const HomePage(),
  'clients': (_) => const ClientsPage(),
  'colors': (_) => const ColorsPage(),
  'register_client': (_) => const RegisterClientPage(),
  'register_color': (_) => const RegisterColorPage(),
};
