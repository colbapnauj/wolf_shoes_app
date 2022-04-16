import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/models/cliente.dart';
import 'package:wolf_app/services/data_service.dart';
import 'package:wolf_app/widgets/custom_botton.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wolf - Clientes'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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

  List<Client> clientsList = [];

  @override
  void initState() {
    _cargarClientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: clientsList.length,
        itemBuilder: (context, index) {
          final client = clientsList[index];
          return ListTile(
            leading: CircleAvatar(
                child: Text(
                    '${client.nombre[0]}${client.aPaterno[0]}${client.aMaterno[0]}')),
            title:
                Text('${client.nombre} ${client.aPaterno} ${client.aMaterno}'),
            trailing: Text(client.telefono),
            onTap: () {
              Navigator.of(context).pushNamed('/client');
            },
          );
        });
  }

  Future<void> _cargarClientes() async {
    final result = await dataService.getClients();

    if (result['ok']) {
      setState(() {
        clientsList = result['clients'];
      });
    }
  }
}
