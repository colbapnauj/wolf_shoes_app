import 'package:flutter/material.dart';
import 'package:wolf_app/widgets/custom_botton.dart';
import 'package:wolf_app/widgets/custom_input.dart';
import 'package:wolf_app/widgets/labels.dart';

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const CustomInput(
              labelText: 'usuario', keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 20),
          const CustomInput(
            obscureText: true,
            labelText: 'password',
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 15),
          CustomButton(text: 'login', onPressed: () {}),
        ],
      ),
    );
  }
}
