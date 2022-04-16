import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/helpers/show_alert.dart';
import 'package:wolf_app/utils/validate.dart';
import 'package:wolf_app/widgets/custom_botton.dart';
import 'package:wolf_app/widgets/custom_input.dart';
import 'package:wolf_app/widgets/labels.dart';
import 'package:wolf_app/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    const Center(
                      child: Text(
                        'Wolf shoes app',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2b2b2b),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Center(
                        child: Text('Login', style: TextStyle(fontSize: 20))),
                    const SizedBox(height: 40),
                    const _Form(),
                    const SizedBox(height: 20),
                    const CustomLabels(
                      text: '¿No tienes una cuenta?',
                      ruta: 'register',
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              )),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CustomInput(
            labelText: 'email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          const SizedBox(height: 20),
          CustomInput(
            obscureText: true,
            labelText: 'password',
            keyboardType: TextInputType.visiblePassword,
            textController: passwordCtrl,
          ),
          const SizedBox(height: 15),
          // Botón recordar email
          Row(
            children: [
              const Text('Recordar email'),
              const SizedBox(width: 10),
              Switch(
                value: rememberMe,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value;
                  });
                },
              ),
            ],
          ),
          CustomButton(
              text: 'login',
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      // validar controllers
                      if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
                        return mostrarAlerta(
                            context, 'Error', 'Ambos campos son obligatorios');
                      }

                      if (!CustomValidate.validateEmail(emailCtrl.text)) {
                        return mostrarAlerta(
                            context, 'Error', 'El email no es válido');
                      }

                      FocusScope.of(context).unfocus();
                      final result = await authService.login(
                          emailCtrl.text.trim(), passwordCtrl.text.trim());

                      if (result['ok']) {
                        // Navegar a otra pantalla
                        Navigator.pushReplacementNamed(context, 'home');
                        mostrarAlerta(context, 'Login correcto',
                            'Bienvenido a Wolf Shoes');

                        if (rememberMe) {
                          authService.saveEmail(emailCtrl.text.trim());
                        } else {
                          authService.deleteEmail();
                        }
                      } else {
                        mostrarAlerta(
                            context, 'Login incorrecto', result['msg']);
                      }
                    }),
        ],
      ),
    );
  }
}
