
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/widgets/scan_tiles.dart';

class DireccionesMapasPage extends StatelessWidget {
  const DireccionesMapasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return ScanTiles(tipo: "geo");

  }
}