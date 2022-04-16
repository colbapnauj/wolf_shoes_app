import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/helpers/show_alert.dart';
import 'package:wolf_app/helpers/show_confirmation.dart';
import 'package:wolf_app/models/color.dart';
import 'package:wolf_app/models/talla.dart';
import 'package:wolf_app/services/data_service.dart';

class TallasPage extends StatelessWidget {
  const TallasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wolf - Tallas'),
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

  List<Talla> tallasList = [];

  @override
  void initState() {
    _cargarTallas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataService = Provider.of<DataService>(context);
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: tallasList.length,
        itemBuilder: (context, index) {
          final talla = tallasList[index];
          return ListTile(
            title: Text('Talla nro: ${talla.talla}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: dataService.isLoading
                  ? null
                  : () {
                      mostrarConfirmacion(
                        context,
                        'Eliminar talla',
                        '¿Estás seguro de eliminar esta talla?',
                        () {
                          tallasList.remove(talla);
                          dataService.deleteTalla(talla.uid);
                          Navigator.of(context).pop();
                        },
                      );
                    },
            ),
          );
        });
  }

  Future<void> _cargarTallas() async {
    final result = await dataService.getTallas();

    if (result['ok']) {
      setState(() {
        tallasList = result['tallas'];
        tallasList.sort((a, b) => a.talla.compareTo(b.talla));
      });
    }
  }
}
