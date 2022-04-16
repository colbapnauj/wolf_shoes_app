import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/helpers/show_alert.dart';
import 'package:wolf_app/services/auth_service.dart';
import 'package:wolf_app/utils/validate.dart';
import 'package:wolf_app/widgets/custom_botton.dart';
import 'package:wolf_app/widgets/custom_input.dart';
import 'package:wolf_app/widgets/labels.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                        child:
                            Text('Registro', style: TextStyle(fontSize: 20))),
                    const SizedBox(height: 40),
                    const _Form(),
                    const SizedBox(height: 20),
                    const CustomLabels(
                      text: '¿Ya tienes una cuenta? - Ir al login',
                      ruta: 'login',
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
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CustomInput(
            labelText: 'nombres',
            keyboardType: TextInputType.emailAddress,
            textController: nameCtrl,
          ),
          const SizedBox(height: 20),
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
          CustomButton(
              text: 'registrar',
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      if (nameCtrl.text.isEmpty ||
                          emailCtrl.text.isEmpty ||
                          passwordCtrl.text.isEmpty) {
                        return mostrarAlerta(context, 'Error',
                            'Todos los campos son obligatorios');
                      }
                      if (!CustomValidate.validateEmail(emailCtrl.text)) {
                        return mostrarAlerta(
                            context, 'Error', 'El email no es válido');
                      }

                      final res = await authService.register(
                          nameCtrl.text, emailCtrl.text, passwordCtrl.text);

                      if (res['ok'] as bool) {
                        Navigator.popAndPushNamed(context, 'home');
                      } else {
                        mostrarAlerta(context, 'Alerta', res['msg']);
                      }
                    }),
        ],
      ),
    );
  }
}
