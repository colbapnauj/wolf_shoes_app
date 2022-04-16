import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/helpers/show_alert.dart';
import 'package:wolf_app/helpers/show_confirmation.dart';
import 'package:wolf_app/models/color.dart';
import 'package:wolf_app/services/data_service.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wolf - Colores'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const _Clients(),
          ),
        ),
      ),
    );
  }
}

class _Clients extends StatefulWidget {
  const _Clients({
    Key? key,
  }) : super(key: key);

  @override
  State<_Clients> createState() => _ClientsState();
}

class _ClientsState extends State<_Clients> {
  final dataService = DataService();

  List<ColorModel> colorsList = [];

  @override
  void initState() {
    _cargarColores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context);
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: colorsList.length,
        itemBuilder: (context, index) {
          final color = colorsList[index];
          return ListTile(
            title: Text(color.nameColor),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: dataService.isLoading
                  ? null
                  : () {
                      mostrarConfirmacion(
                        context,
                        'Eliminar color',
                        '¿Estás seguro de eliminar este color?',
                        () {
                          colorsList.remove(color);
                          dataService.deleteColor(color.uid);
                          Navigator.of(context).pop();
                        },
                      );
                    },
            ),
          );
        });
  }

  Future<void> _cargarColores() async {
    final result = await dataService.getColors();

    if (result['ok']) {
      setState(() {
        colorsList = result['colors'];
      });
    }
  }
}
