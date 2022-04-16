import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/helpers/show_confirmation.dart';
import 'package:wolf_app/models/talla.dart';
import 'package:wolf_app/models/zapato.dart';
import 'package:wolf_app/services/data_service.dart';

class ZapatosPage extends StatelessWidget {
  const ZapatosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wolf - Modelos de Zapatos'),
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

  List<Zapato> zapatosList = [];

  @override
  void initState() {
    _cargarZapatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context);
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: zapatosList.length,
        itemBuilder: (context, index) {
          final zapato = zapatosList[index];
          return ListTile(
            title: Text('Modelo: ${zapato.nombreModelo}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: dataService.isLoading
                  ? null
                  : () {
                      mostrarConfirmacion(
                        context,
                        'Eliminar modelo',
                        '¿Estás seguro de eliminar este modelo?',
                        () {
                          zapatosList.remove(zapato);
                          dataService.deleteModeloZapato(zapato.uid);
                          Navigator.of(context).pop();
                        },
                      );
                    },
            ),
          );
        });
  }

  Future<void> _cargarZapatos() async {
    final result = await dataService.getModelosZapatos();

    if (result['ok']) {
      setState(() {
        zapatosList = result['zapatos'];
      });
    }
  }
}
