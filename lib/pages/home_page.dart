import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolf_app/services/auth_service.dart';
import 'package:wolf_app/widgets/custom_botton.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wolf Shoes App - Inicio'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.cyanAccent,
                    radius: 30,
                    child: Text(authService.user.nombre[0].toUpperCase()),
                  ),
                  const SizedBox(width: 10),
                  // TODO Usuario también debe tener propiedad "PUESTO - CARGO"
                  // Text('Juan Pablo - Vendedor'),
                  Text(authService.user.nombre),
                ],
              ),
              const Divider(thickness: 2),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text('Operaciones'),
                      ListTile(
                        title: const Text('Proformas'),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: [
                          CustomButton(
                            text: 'Clientes',
                            onPressed: () {
                              Navigator.pushNamed(context, 'clients');
                            },
                          ),
                          CustomButton(
                            text: 'Productos',
                            onPressed: () {},
                          ),
                          CustomButton(
                            text: 'Vendedores',
                            onPressed: () {},
                          ),
                          CustomButton(
                            text: 'Proformas',
                            onPressed: () {},
                          ),
                          CustomButton(
                            text: 'Facturas',
                            onPressed: () {},
                          ),
                          CustomButton(
                            text: 'Cobros',
                            onPressed: () {},
                          ),
                          CustomButton(
                            text: 'Pagos',
                            onPressed: () {},
                          ),
                          CustomButton(
                            text: 'Caja',
                            onPressed: () {},
                          ),
                          CustomButton(
                            text: 'Reportes',
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const Divider(thickness: 2),
                      const Text('Registrar'),
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        children: [
                          CustomButton(
                            text: 'Nuevo cliente',
                            onPressed: () {
                              Navigator.pushNamed(context, 'register_client');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
