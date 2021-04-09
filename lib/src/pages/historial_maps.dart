
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HistorialMapasPage extends StatefulWidget {

  @override
  _HistorialMapasPageState createState() => _HistorialMapasPageState();
}


class _HistorialMapasPageState extends State<HistorialMapasPage> {
  //Completer contendra el google mas controller.
  Completer <GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    //Reciviendo la información
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final CameraPosition puntoInicial = CameraPosition(
      bearing: 192.8334901395799,
      target: scan.getLatLng(),
      tilt: 50,
      zoom: 15);

    //MARCADORES
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLng()

    ));


    return Scaffold(
      appBar: AppBar(
        title: Text("MAPA"), 
        centerTitle: true,
        actions: [
          IconButton( // Para regresar la camara al punto inicial (en este caso el marcador)
            icon: Icon(Icons.location_city, color: Colors.white,),
            onPressed: ()async{
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  new CameraPosition(
                    target: scan.getLatLng(),
                    tilt: 50,
                    zoom: 15
                  )
                )
              );
            }
          )
        ],
      ),
      body: GoogleMap(
        mapType: mapType, //Cambiando el tipo de vista del mapa
        initialCameraPosition: puntoInicial,
        markers: markers,//Colocando un marcador
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        

        child: Icon(Icons.layers),
        onPressed: (){
          if(mapType == MapType.normal){
            mapType = MapType.satellite;
          }else{
            mapType = MapType.normal;
          }

          setState(() { });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}