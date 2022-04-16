import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/routes/routes.dart';
import 'package:wolf_app/services/auth_service.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
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
