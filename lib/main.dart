
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/pages/historial_maps.dart';
import 'package:qr_reader/src/pages/home_page.dart';
import 'package:qr_reader/src/pages/mapa_page.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ScanListProvider(),),
        ChangeNotifierProvider(create: (_)=> UiProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Readey',
        initialRoute: 'home',
        routes: {
          'home'  :  (_)=> HomePage(),
          'mapa'  :  (_)=> HistorialMapasPage(),
        },
        //theme: ThemeData.dark(),
        theme: ThemeData( //Modificando el tema de la aplicación
          primaryColor: Colors.green,
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.green)
        ),
      ),
    );
  }
}