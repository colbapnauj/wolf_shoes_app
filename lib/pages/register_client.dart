import 'package:flutter/material.dart';
import 'package:wolf_app/widgets/custom_botton.dart';
import 'package:wolf_app/widgets/custom_input.dart';
import 'package:wolf_app/widgets/labels.dart';

class RegisterClientPage extends StatelessWidget {
  const RegisterClientPage({Key? key}) : super(key: key);

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
                        child: Text('Registro de clientes',
                            style: TextStyle(fontSize: 20))),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const CustomInput(
              labelText: 'dni', keyboardType: TextInputType.number),
          const SizedBox(height: 20),
          const CustomInput(
            labelText: 'nombres',
            keyboardType: TextInputType.text,
            autocorrect: true,
          ),
          const SizedBox(height: 20),
          const CustomInput(
            labelText: 'apellido paterno',
            keyboardType: TextInputType.text,
            autocorrect: true,
          ),
          const SizedBox(height: 20),
          const CustomInput(
            labelText: 'apellido materno',
            keyboardType: TextInputType.text,
            autocorrect: true,
          ),
          const SizedBox(height: 20),
          const CustomInput(
            labelText: 'teléfono',
            keyboardType: TextInputType.text,
            autocorrect: true,
          ),
          const SizedBox(height: 20),
          const CustomInput(
            labelText: 'dirección',
            keyboardType: TextInputType.text,
            autocorrect: true,
          ),
          const SizedBox(height: 20),
          CustomButton(text: 'registrar', onPressed: () {}),
        ],
      ),
    );
  }
}
