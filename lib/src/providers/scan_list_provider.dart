

import 'package:flutter/material.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];

  // Opcion seleccionada
  String tipoSeleccionado ="http";
  
  Future<ScanModel> nuevoScan(String valor) async{

    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //Asignar el ID de la base de datos al Modelo
    nuevoScan.id = id;


    if(this.tipoSeleccionado == nuevoScan.tipo){
      this.scans.add(nuevoScan);
      //Ahora toca notifica a cualquier Widget interaso en saber el cambio
      notifyListeners();
    }

    return nuevoScan;

  }

  cargarScnas() async{
    final scans = await DBProvider.db.getAll();
    this.scans=[...scans];
    notifyListeners();

  }

  cargarScansTipo(String tipo)async{
    final scans = await DBProvider.db.getForType(tipo);
    this.scans=[...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos()async{
    await DBProvider.db.deleteAllScans();
    this.scans=[];
    notifyListeners();
  }

  borrarScanPorId(int id)async{
    await DBProvider.db.deleteScans(id);
    this.cargarScansTipo(this.tipoSeleccionado);
  }

}