import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/helpers/show_alert.dart';
import 'package:wolf_app/models/cliente.dart';
import 'package:wolf_app/services/data_service.dart';
import 'package:wolf_app/widgets/custom_botton.dart';
import 'package:wolf_app/widgets/custom_input.dart';

class RegisterClientPage extends StatelessWidget {
  const RegisterClientPage({Key? key}) : super(key: key);

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
                        Text('Nuevo Cliente', style: TextStyle(fontSize: 20))),
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
  TextEditingController documentCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController aPaternoCtrl = TextEditingController();
  TextEditingController aMaternoCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  void fakeData() {
    documentCtrl.text = '12345678';
    nameCtrl.text = 'Juan';
    aPaternoCtrl.text = 'Perez';
    aMaternoCtrl.text = 'Perez';
    telefonoCtrl.text = '945495698';
    addressCtrl.text = 'Calle 123';
  }

  @override
  void initState() {
    if (kDebugMode) {
      fakeData();
    }
    super.initState();
  }

  @override
  void dispose() {
    documentCtrl.dispose();
    nameCtrl.dispose();
    aPaternoCtrl.dispose();
    aMaternoCtrl.dispose();
    telefonoCtrl.dispose();
    addressCtrl.dispose();
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
                labelText: 'dni',
                keyboardType: TextInputType.number,
                textController: documentCtrl,
              ),
              const SizedBox(height: 20),
              CustomInput(
                labelText: 'nombres',
                keyboardType: TextInputType.text,
                autocorrect: true,
                textController: nameCtrl,
              ),
              const SizedBox(height: 20),
              CustomInput(
                labelText: 'apellido paterno',
                keyboardType: TextInputType.text,
                autocorrect: true,
                textController: aPaternoCtrl,
              ),
              const SizedBox(height: 20),
              CustomInput(
                labelText: 'apellido materno',
                keyboardType: TextInputType.text,
                autocorrect: true,
                textController: aMaternoCtrl,
              ),
              const SizedBox(height: 20),
              CustomInput(
                labelText: 'teléfono',
                keyboardType: TextInputType.text,
                autocorrect: true,
                textController: telefonoCtrl,
              ),
              const SizedBox(height: 20),
              CustomInput(
                labelText: 'dirección',
                keyboardType: TextInputType.text,
                autocorrect: true,
                textController: addressCtrl,
              ),
              const SizedBox(height: 20),
              CustomButton(
                  text: 'Registrar nuevo cliente',
                  onPressed: dataService.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();

                          // Validar controllers
                          if (documentCtrl.text.isEmpty ||
                              nameCtrl.text.isEmpty ||
                              aPaternoCtrl.text.isEmpty ||
                              aMaternoCtrl.text.isEmpty ||
                              telefonoCtrl.text.isEmpty ||
                              addressCtrl.text.isEmpty) {
                            mostrarAlerta(
                                context, 'Error', 'Complete todos los campos');
                            return;
                          }

                          if (documentCtrl.text.length != 8) {
                            mostrarAlerta(context, 'Error',
                                'El dni debe tener 8 dígitos');
                            return;
                          }

                          if (telefonoCtrl.text.length != 9) {
                            mostrarAlerta(context, 'Error',
                                'El teléfono debe tener 9 dígitos');
                            return;
                          }

                          print('Registrando nuevo cliente');
                          Client client = Client(
                              dni: documentCtrl.text.trim(),
                              nombre: nameCtrl.text.trim(),
                              aPaterno: aPaternoCtrl.text.trim(),
                              aMaterno: aMaternoCtrl.text.trim(),
                              telefono: telefonoCtrl.text.trim(),
                              direccion: addressCtrl.text.trim());

                          final result = await dataService.createClient(client);

                          if (result['ok']) {
                            Navigator.pop(context);
                            mostrarAlerta(context, 'Registro exitoso',
                                'El cliente se registró correctamente');
                          } else {
                            mostrarAlerta(
                                context,
                                'Error',
                                // 'No se pudo registrar el cliente');
                                result['msg']);
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
