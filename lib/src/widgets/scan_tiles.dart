
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanTiles extends StatelessWidget {
  
  final String tipo;

  const ScanTiles({@required this.tipo});

  @override
  Widget build(BuildContext context) {
     //Aqui si se necesita estar ecuchando los cambios para redibujar en cada insercción
    final scanListProvider = Provider.of<ScanListProvider>(context); 

    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (_, i){
        return Dismissible(// Me permite remover fisicamente un item del listados
          key: UniqueKey(),
          background: Container(color: Colors.red,), // Color de fondo de cada elemento de la lista
          onDismissed: (DismissDirection direction){ // Es una propiedad donde podemos poner una función
            Provider.of<ScanListProvider>(context, listen: false).borrarScanPorId(scanListProvider.scans[i].id);
          },
          child: ListTile(
            leading: Icon(
              (this.tipo == 'http')? Icons.home : Icons.map_outlined,
              color: Theme.of(context).primaryColor,),
            title: Text(scanListProvider.scans[i].valor),
            subtitle: Text(scanListProvider.scans[i].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            onTap: (){
              return launchURL(context, scanListProvider.scans[i]);
            },
          ),
        );
      },

    );
  }
}