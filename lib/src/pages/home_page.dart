
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/pages/historial_maps.dart';
import 'package:qr_reader/src/pages/mapa_page.dart';
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';
import 'package:qr_reader/src/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/src/widgets/scan_button.dart';

import 'direciones_mapas_page.dart';

class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Historial"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white,),
            onPressed: (){
              Provider.of<ScanListProvider>(context, listen: false).borrarTodos();

            }
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Optener el selected Menu Opt
    final uiProvider = Provider.of<UiProvider>(context);
    // Cambiar para mostrar la página respectiva
    final currenIndex = uiProvider.selectedMenuOpt;

    //DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.getScanById(3).then((scan) => print(scan.valor));
    //DBProvider.db.deleteAllScans().then(print);

    // Usar el ScanList Provider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);


    switch(currenIndex){

      case 0: 
        scanListProvider.cargarScansTipo('geo');
        return MapaPage();
      case 1: 
        scanListProvider.cargarScansTipo('http');
        return DireccionesMapasPage();
      default:
        return MapaPage();
    }
    
  }
}