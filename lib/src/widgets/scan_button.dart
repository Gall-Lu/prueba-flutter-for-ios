
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async{
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#3D8BEF", "Cancelar", false, ScanMode.QR);
        //final barcodeScanRes ="https://www.facebook.com/gall.lu.1/";
        //final barcodeScanRes ="geo:15.683363393172046,-92.01838269535868";

        if(barcodeScanRes == -1){
          return;
        }

        // Ponemos en false el listen pora que no se vuelva a redibujar
        // El provider necesita bucar el modelo ScanListProvider
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false); 
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        //Cuando toque el boton voy a navegar a la pantalla respectiva
        launchURL(context, nuevoScan);

      },

    );
  }
}