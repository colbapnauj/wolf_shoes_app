import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/controller/global_controller.dart';
import 'package:wolf_app/routes/routes.dart';
import 'package:wolf_app/services/auth_service.dart';
import 'package:wolf_app/services/data_service.dart';

void main() async {
  final GlobalController gCtrl = GlobalController();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => DataService()),
        // ChangeNotifierProvider(create: (_) => ClientsProvider()),
      ],
      child: MaterialApp(
        title: 'Wolf Shoes App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
