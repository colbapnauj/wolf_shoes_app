import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/pages/home_page.dart';
import 'package:wolf_app/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Center(child: Text('Espere...'));
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final isLoggedIn = await authService.isLoggedIn();
    if (isLoggedIn) {
      // Navigator.pushReplacementNamed(context, 'home');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const HomePage(),
              transitionDuration: const Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
