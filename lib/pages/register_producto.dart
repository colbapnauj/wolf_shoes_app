import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/helpers/show_alert.dart';
import 'package:wolf_app/models/color.dart';
import 'package:wolf_app/models/producto.dart';
import 'package:wolf_app/models/talla.dart';
import 'package:wolf_app/models/zapato.dart';
import 'package:wolf_app/services/data_service.dart';
import 'package:wolf_app/widgets/custom_botton.dart';
import 'package:wolf_app/widgets/custom_input.dart';
import 'package:wolf_app/widgets/drop_down_button.dart';

class RegisterProductPage extends StatelessWidget {
  const RegisterProductPage({Key? key}) : super(key: key);

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
                        Text('Nuevo Producto', style: TextStyle(fontSize: 20))),
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
  DataService dataService = DataService();
  TextEditingController cantidadCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();

  List<Zapato> zapatosList = [Zapato(nombreModelo: "S1 MED", uid: "1")];
  List<ColorModel> colorsList = [];
  List<Talla> tallasList = [];

  String? zapatoIdSelected;
  String? tallaIdSelected;
  String? colorIdSelected;

  @override
  void initState() {
    _cargarZapatos();
    _cargarTallas();
    _cargarColores();
    super.initState();
  }

  @override
  void dispose() {
    cantidadCtrl.dispose();
    priceCtrl.dispose();

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
          child: zapatosList.isEmpty || colorsList.isEmpty || tallasList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const _Title('Modelo:'),
                    GlobalDropdown(
                      value: zapatoIdSelected,
                      items: zapatosList,
                      onChanged: (String? value) {
                        setState(() {
                          zapatoIdSelected = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const _Title('Talla:'),
                    GlobalDropdown(
                      value: tallaIdSelected,
                      items: tallasList,
                      onChanged: (String? value) {
                        setState(() {
                          tallaIdSelected = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const _Title('Color:'),
                    GlobalDropdown(
                      value: colorIdSelected,
                      items: colorsList,
                      onChanged: (String? value) {
                        setState(() {
                          colorIdSelected = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const _Title('Cantidad disponible:'),
                    CustomInput(
                      labelText: 'cantidad',
                      textController: cantidadCtrl,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    const _Title('Precio:'),
                    CustomInput(
                      labelText: 'precio',
                      textController: priceCtrl,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                        text: 'Registrar nuevo producto',
                        onPressed: dataService.isLoading
                            ? null
                            : () async {
                                FocusScope.of(context).unfocus();

                                // Validar controllers
                                if (zapatoIdSelected == null ||
                                    tallaIdSelected == null ||
                                    colorIdSelected == null ||
                                    cantidadCtrl.text.trim().isEmpty ||
                                    priceCtrl.text.trim().isEmpty) {
                                  mostrarAlerta(context, 'Error',
                                      'Complete todos los campos');
                                  return;
                                }

                                Producto producto = Producto(
                                  uid: "0",
                                  idColor: colorIdSelected!,
                                  idModelo: zapatoIdSelected!,
                                  idTalla: tallaIdSelected!,
                                  cantidad: cantidadCtrl.text,
                                  precio: priceCtrl.text,
                                );

                                final result =
                                    await dataService.createProduct(producto);

                                if (result['ok']) {
                                  Navigator.pop(context);
                                  mostrarAlerta(context, 'Registro exitoso',
                                      'El producto se registró correctamente');
                                } else {
                                  mostrarAlerta(
                                      context, 'Error', result['msg']);
                                }
                              }),
                    const SizedBox(height: 20)
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _cargarZapatos() async {
    final result = await dataService.getModelosZapatos();

    if (result['ok']) {
      setState(() {
        zapatosList = result['zapatos'];
        zapatosList.insert(
            0, Zapato(nombreModelo: "Seleccione un modelo", uid: "0"));
      });
    }
  }

  Future<void> _cargarTallas() async {
    final result = await dataService.getTallas();

    if (result['ok']) {
      setState(() {
        tallasList = result['tallas'];
        tallasList.sort((a, b) => a.talla.compareTo(b.talla));
        tallasList.insert(0, Talla(talla: "Seleccione una talla", uid: "0"));
      });
    }
  }

  Future<void> _cargarColores() async {
    final result = await dataService.getColors();

    if (result['ok']) {
      setState(() {
        colorsList = result['colors'];
        colorsList.insert(
            0, ColorModel(nameColor: "Seleccione un color", uid: "0"));
      });
    }
  }
}

class _Title extends StatelessWidget {
  const _Title(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 10),
      ],
    );
  }
}
