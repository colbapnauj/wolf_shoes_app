import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/helpers/show_alert.dart';
import 'package:wolf_app/services/data_service.dart';
import 'package:wolf_app/widgets/custom_botton.dart';
import 'package:wolf_app/widgets/custom_input.dart';

class RegisterModeloPage extends StatelessWidget {
  const RegisterModeloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Registros',
          ),
        ),
        backgroundColor: const Color(0xfff2f2f2),
        body: SafeArea(
          child: SizedBox(
            child: Column(
              children: const [
                SizedBox(height: 40),
                Center(
                    child:
                        Text('Nuevo Modelo', style: TextStyle(fontSize: 20))),
                SizedBox(height: 30),
                Expanded(child: _Form()),
              ],
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  TextEditingController nameModelCtrl = TextEditingController();

  @override
  void dispose() {
    nameModelCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          child: Column(
            children: [
              CustomInput(
                labelText: 'modelo',
                keyboardType: TextInputType.text,
                autocorrect: true,
                textController: nameModelCtrl,
              ),
              const SizedBox(height: 20),
              CustomButton(
                  text: 'Registrar nuevo modelo',
                  onPressed: dataService.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();

                          // Validar controllers
                          if (nameModelCtrl.text.isEmpty) {
                            mostrarAlerta(context, 'Error',
                                'El campo nombre de modelo no puede estar vacío');
                            return;
                          }

                          final result = await dataService
                              .createModelo(nameModelCtrl.text);

                          if (result['ok']) {
                            Navigator.pop(context);
                            mostrarAlerta(context, 'Registro exitoso',
                                'Nombre de Modelo registrado correctamente');
                          } else {
                            mostrarAlerta(context, 'Error', result['msg']);
                          }
                        }),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
