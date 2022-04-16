import 'package:flutter/material.dart';
import 'package:wolf_app/models/ProducDetailResponse.dart';
import 'package:wolf_app/services/data_service.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wolf - Productos'),
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

  List<ProductDetail> productsList = [];

  @override
  void initState() {
    _cargarProductos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: productsList.length,
      itemBuilder: (context, index) {
        final product = productsList[index];
        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Modelo: ${product.modelo.nombreModelo}'),
              Text('Color: ${product.color.nameColor}'),
              Text('Talla: ${product.talla.talla}'),
            ],
          ),
          onTap: () {},
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  Future<void> _cargarProductos() async {
    final result = await dataService.getProductos();

    if (result['ok']) {
      setState(() {
        productsList = result['clients'];
      });
    }
  }
}
